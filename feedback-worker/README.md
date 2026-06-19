# Feedback-Worker (Cloudflare + D1)

Privat, cookie-fri feedback-modtager til DST_help-sitet. Indsendelser fra
feedback-boksen i højremargenen lander i en D1-database, som **kun du** kan se
via en hemmelig admin-URL. Ingen e-mail, ingen tredjepart, ingen cookies.

## Engangsopsætning

Kør alt herfra (`feedback-worker/`). Kræver Node + Cloudflare-konto.

```bash
# 1. Log ind (åbner browseren)
npx wrangler login

# 2. Opret D1-databasen
npx wrangler d1 create dsthelp-feedback
#    -> kopiér "database_id" fra outputtet ind i wrangler.toml
#       (erstatter INDSÆT_DATABASE_ID_HER)

# 3. Opret tabellen i den rigtige (remote) database
npx wrangler d1 execute dsthelp-feedback --remote --file=schema.sql

# 4. Sæt en hemmelig admin-nøgle (vælg en lang tilfældig streng, fx fra en password-manager)
npx wrangler secret put ADMIN_KEY
#    -> indtast nøglen når den spørger

# 5. Deploy
npx wrangler deploy
#    -> noter URL'en, fx https://dsthelp-feedback.DIT-SUBDOMÆNE.workers.dev
```

## Forbind sitet til Workeren

I `docs/_feedback.html`, erstat placeholderen:

```js
var FEEDBACK_ENDPOINT = "https://dsthelp-feedback.CHANGE-ME.workers.dev";
```

med din rigtige Worker-URL fra trin 5. Commit + push → GitHub Actions bygger sitet.

## Se feedback

Åbn i browseren (hold nøglen privat — del den ikke):

```
https://dsthelp-feedback.DIT-SUBDOMÆNE.workers.dev/admin?key=DIN_ADMIN_KEY
```

Viser de seneste 500 indsendelser med side, besked og evt. e-mail.

## Noter

- **CORS er låst** til `https://saras-clin.github.io` i `src/index.js`
  (`ALLOWED_ORIGIN`). Skifter sitet domæne, så ret den konstant og deploy igen.
- **Cookie-fri:** Workeren sætter ingen cookies, og feedback-boksen er ren
  første-parts HTML/JS — ingen banner nødvendig.
- **Spam:** et skjult honeypot-felt fanger simple bots; beskeder valideres for
  længde og e-mail-format.
- **Lokal Quarto-preview** sender fra `localhost` og bliver afvist af CORS —
  det er forventet; feedback virker kun på det publicerede site.
```
