@_default:
  just --list --unsorted

# Run all build-related recipes in the justfile
run-all: check-all format-md build-all

# Run all check-related recipes
check-all: check-spelling check-urls

# Run all build-related recipes
build-all: build-contributors build-website build-readme

# List all TODO items in the repository
list-todos:
  grep -R -n \
    --exclude="*.code-snippets" \
    --exclude-dir=.quarto \
    --exclude=justfile \
    --exclude-dir=_site \
    "TODO" *

# Install the command-line tools this project uses (macOS + Homebrew)
install:
  brew install uv lychee air      # uv (tool runner), lychee (links), air (R formatter)
  uv tool install jarl-linter     # jarl (R linter); then run `uv tool update-shell` once so ~/.local/bin is on PATH

# Install the pre-commit hooks
install-precommit:
  uvx pre-commit install
  uvx pre-commit autoupdate
  uvx pre-commit run --all-files

# TODO: If you want to use the sdca-theme, we can uncomment this.
# Update (or add if not present) the Quarto sdca-theme extension
# update-quarto-theme:
#   quarto update steno-aarhus/sdca-theme --no-prompt

# Check for spelling errors in files
check-spelling:
  uvx typos --config .config/typos.toml

# Check that URLs work
check-urls:
  lychee . \
    --config .config/lychee.toml \
    --verbose \
    --extensions md,qmd \
    --exclude "github\.com" \
    --exclude-path "_badges.qmd" \
    --exclude-path "README.md" \
    --exclude-path "da/_parked_content.md"

# Lint R code with jarl
check-r:
  uvx --from jarl-linter jarl check .

# Format the docs: markdown + R code cells (panache runs air on the R)
format-md:
  uvx --from panache-cli panache format .

# Re-build the README file from the Quarto version
build-readme:
  uvx --from quarto quarto render README.qmd --to gfm

# Generate a Quarto include file with the contributors
build-contributors:
  sh ./tools/get-contributors.sh steno-aarhus/registers-guide > includes/_contributors.qmd

# Build the website using Quarto
build-website:
  uvx --from quarto quarto render

# Preview the website with automatic reload on changes
preview-website:
  uvx --from quarto quarto preview

# Check for and apply updates from the template
update-from-template:
  uvx copier update --defaults

# Reset repo changes to match the template
reset-from-template:
  uvx copier recopy --defaults
