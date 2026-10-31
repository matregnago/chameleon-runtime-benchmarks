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

O Chameleon e o PaRSEC são baixados pelo próprio Nix (ver `nix/chameleon.nix` e `nix/parsec.nix`), não é preciso cloná-los à mão.

4. Entrar no ambiente do `nix` de desenvolvimento:

```bash
nix develop            # shell padrão: ferramentas de análise (R/StarVZ, marp, just)
nix develop .#starpu   # shell com o Chameleon compilado sobre o StarPU
nix develop .#parsec   # shell com o Chameleon compilado sobre o PaRSEC
```

## Slides

Os slides ficam na pasta `slides`, com uma subpasta por apresentação (`proposta`, `parcial`, `final`, `sscad`). Cada uma tem um `<nome>.md`, escrito em `markdown` para o [Marp](https://marp.app), e o `<nome>.pdf` já compilado.

### Slides do SSCAD

O `marp`, o `chromium` (usado pelo Marp para gerar o PDF) e o `just` vêm no shell padrão do Nix. Para compilar, rode a partir da raiz do repositório:

```bash
nix develop
just slides            # compila slides/sscad/sscad.md -> slides/sscad/sscad.pdf
```

Ou, sem entrar no shell:

```bash
nix develop -c just slides
```

Os slides usam as figuras de `plots/final/` (caminhos relativos `../../plots/final/...`), que já estão versionadas, então não é preciso ter os dados para compilar. Por isso a flag `--allow-local-files` é obrigatória: sem ela o Marp não carrega as imagens no PDF. Para regenerar as figuras a partir dos dados, veja os scripts em `scripts/analysis/` (seção abaixo).

Para recompilar automaticamente a cada vez que o `.md` for salvo:

```bash
marp --pdf --allow-local-files --watch slides/sscad/sscad.md -o slides/sscad/sscad.pdf
```

### Outras apresentações

A mesma receita funciona para as outras pastas, passando o nome:

```bash
just slides proposta   # slides/proposta/proposta.md -> slides/proposta/proposta.pdf
just slides final
```

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
