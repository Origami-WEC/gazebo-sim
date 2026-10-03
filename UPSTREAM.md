# Provenienza — questo repo è un mirror di `asv_wave_sim`

Questo repository **non contiene codice scritto da Origami**: è la copia di lavoro di

> **upstream:** <https://github.com/srmainwaring/asv_wave_sim>
> **autore originale:** srmainwaring (e contributori) · licenza: vedi `LICENSE`

Serve a due cose concrete:

1. dare a `maritime_ws` (che lo consuma come **submodule** in `src/gazebo-sim`) un
   riferimento stabile dentro l'org, invece di puntare a un repo di terze parti;
2. tenere un **ref con nome** (`gz-jetty`) sul lavoro di compatibilità multi-versione
   di Gazebo, che sull'upstream è raggiungibile ma non ha un branch omonimo.

## Stato dei ref (verificato 2026-10-03)

| ref qui | commit | data | contenuto |
|---|---|---|---|
| `master` | `8574e9ed` | 2025-10-13 | "added bash environemnt setup script" (ultimo commit della serie jammy/caravel) |
| `gz-jetty` | `6a0414f4` | 2026-09-07 | "fix: robust Ogre cleanup, mesh name conflict, and env sourcing" |

I due commit che riguardano l'**integrazione con le diverse versioni di Gazebo** sono
`fdc0a223` — *"feat: Gazebo multi-version compat via unversioned find_package"* — e
`6a0414f4`, entrambi del 2026-09-07.

## Nessuna modifica locale (verificato, non supposto)

Controllati **tutti** i commit dei due ref: `master` 117, `gz-jetty` 119.
**Zero** commit che non esistano identici sull'upstream. Al 2026-10-03 questo repo non
aggiunge una sola riga di codice all'upstream: è un mirror, non un fork divergente.

Questo va tenuto presente prima di modificare qualcosa qui: **qualunque patch locale
rompe l'uguaglianza e va elencata in questo file**, altrimenti alla prossima
sincronizzazione si perde o si duplica senza saperlo.

## Sincronizzare

```bash
git remote add upstream https://github.com/srmainwaring/asv_wave_sim.git
git fetch upstream
git log --oneline HEAD..upstream/master      # cosa è arrivato
git log --oneline upstream/master..HEAD      # cosa c'è solo qui (oggi: il doc che state leggendo)
```

## Nota

I badge in cima al `README.md` puntano ai workflow CI **dell'upstream**
(`srmainwaring/asv_wave_sim/actions/...`): misurano la CI di quel repo, non questa.
I workflow in `.github/workflows` sono quelli ereditati dall'upstream.
