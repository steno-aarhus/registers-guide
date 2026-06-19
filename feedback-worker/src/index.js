// DST_help feedback-Worker → Cloudflare D1
//
// Endpoints:
//   POST /            modtager feedback (JSON) fra sitet og gemmer i D1
//   GET  /admin?key=  privat HTML-oversigt over indsendelser (kræver ADMIN_KEY)
//
// Hemmelighed: sæt ADMIN_KEY med `wrangler secret put ADMIN_KEY`.

const ALLOWED_ORIGIN = "https://saras-clin.github.io";

function corsHeaders(origin) {
  return {
    "Access-Control-Allow-Origin": ALLOWED_ORIGIN,
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type",
    Vary: "Origin",
  };
}

function json(obj, status, origin) {
  return new Response(JSON.stringify(obj), {
    status,
    headers: { "Content-Type": "application/json", ...corsHeaders(origin) },
  });
}

function esc(s) {
  return (s || "").toString().replace(/[&<>"]/g, (c) => ({
    "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;",
  }[c]));
}

function renderAdmin(rows) {
  const items = rows.map((r) => `
      <tr>
        <td>${r.id}</td>
        <td>${esc(r.created_at)}</td>
        <td><a href="${esc(r.page)}" target="_blank" rel="noopener">${esc(r.page)}</a><br><small>${esc(r.title)}</small></td>
        <td>${esc(r.message)}</td>
        <td>${r.email ? `<a href="mailto:${esc(r.email)}">${esc(r.email)}</a>` : "—"}</td>
      </tr>`).join("");
  return `<!doctype html><html lang="da"><head><meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Feedback — DST_help</title>
    <style>
      body { font: 15px system-ui, sans-serif; margin: 2rem; color: #222; }
      h1 { font-size: 1.4rem; }
      table { border-collapse: collapse; width: 100%; }
      td, th { border: 1px solid #ccc; padding: 0.5rem 0.6rem; text-align: left; vertical-align: top; }
      th { background: #f0f2f5; }
      td:nth-child(4) { max-width: 48ch; white-space: pre-wrap; }
      small { color: #777; }
    </style></head>
    <body>
      <h1>Feedback (${rows.length})</h1>
      <table>
        <tr><th>#</th><th>Tid (UTC)</th><th>Side</th><th>Besked</th><th>E-mail</th></tr>
        ${items || '<tr><td colspan="5">Ingen indsendelser endnu.</td></tr>'}
      </table>
    </body></html>`;
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    const origin = request.headers.get("Origin") || "";

    // CORS preflight
    if (request.method === "OPTIONS") {
      return new Response(null, { status: 204, headers: corsHeaders(origin) });
    }

    // Privat admin-oversigt
    if (request.method === "GET" && url.pathname === "/admin") {
      const key = url.searchParams.get("key");
      if (!env.ADMIN_KEY || key !== env.ADMIN_KEY) {
        return new Response("Unauthorized", { status: 401 });
      }
      const { results } = await env.DB.prepare(
        "SELECT id, created_at, page, title, message, email FROM submissions ORDER BY id DESC LIMIT 500"
      ).all();
      return new Response(renderAdmin(results), {
        headers: { "Content-Type": "text/html; charset=utf-8", "Cache-Control": "no-store" },
      });
    }

    // Modtag feedback
    if (request.method === "POST" && url.pathname === "/") {
      if (origin !== ALLOWED_ORIGIN) {
        return json({ error: "Forbidden origin" }, 403, origin);
      }

      let data;
      try {
        data = await request.json();
      } catch {
        return json({ error: "Bad JSON" }, 400, origin);
      }

      // Honeypot: udfyldt af bots → lad som om det lykkedes, gem ikke
      if (data.website) return json({ ok: true }, 200, origin);

      const message = (data.message || "").toString().trim();
      const email = (data.email || "").toString().trim().slice(0, 200);
      const page = (data.page || "").toString().slice(0, 300);
      const title = (data.title || "").toString().slice(0, 300);

      if (message.length < 2 || message.length > 4000) {
        return json({ error: "Invalid message" }, 422, origin);
      }
      if (email && !/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) {
        return json({ error: "Invalid email" }, 422, origin);
      }

      const ua = request.headers.get("User-Agent") || "";
      await env.DB.prepare(
        "INSERT INTO submissions (page, title, message, email, user_agent) VALUES (?, ?, ?, ?, ?)"
      ).bind(page, title, message, email, ua).run();

      return json({ ok: true }, 200, origin);
    }

    return new Response("Not found", { status: 404, headers: corsHeaders(origin) });
  },
};
