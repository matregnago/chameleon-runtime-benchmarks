# Passos para rodar o projeto

1. Instalar o `Nix`:

```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

2. Habilitar os flakes:

Adicione a linha a seguir em `~/.config/nix/nix.conf` ou `/etc/nix/nix.conf`:

```bash
experimental-features = nix-command flakes
```

3. Clonar o repositório:

```bash
git clone https://github.com/matregnago/chameleon-runtime-benchmarks.git
cd chameleon-runtime-benchmarks
```

O Chameleon e o PaRSEC são baixados pelo próprio Nix (ver `chameleon.nix` e `parsec.nix`), não é preciso cloná-los à mão.

4. Entrar no ambiente do `nix` de desenvolvimento:

```bash
nix develop            # shell padrão: ferramentas de análise (R/StarVZ, marp, just)
nix develop .#starpu   # shell com o Chameleon compilado sobre o StarPU
nix develop .#parsec   # shell com o Chameleon compilado sobre o PaRSEC
```

## Slides

Os slides estão localizados na pasta `slides`. Eles são escritos em `markdown` e compilados para pdf com o [Marp](https://marp.app) a partir dos seguintes comandos:

```bash
cd slides/part1
marp --pdf part1.md --allow-local-files
```
Isso gera um arquivo chamado `part1.pdf`.

## DOE e Análise dos Dados
Os scripts estão na pasta `scripts`:

- `scripts/doe/` — gera os designs em `doe/*.csv` (rode a partir da raiz do repositório, ex.: `Rscript scripts/doe/doe_block_size.r`);
- `scripts/run.sh` — executa o design (`DESIGN_FILE`) para um runtime (chamado pelos jobs em `slurm/`, que copiam o `doe/*.csv` correspondente);
- `scripts/process_data/` — converte os traces brutos em parquets StarVZ (`trace_phase1.sh`, `parsec_phase1.sh` e os conversores `parsec_*_to_parquet.r`);
- `scripts/analysis/` — gera as figuras a partir dos resultados/parquets. Exemplo:

```bash
Rscript scripts/analysis/plot_n_size_compare.r
scripts/process_data/parsec_phase1.sh data/<job>/runs/00*_parsec_*
```
