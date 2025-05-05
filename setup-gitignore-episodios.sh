#!/bin/bash

# Criar a pasta e o .gitkeep, se ainda não existirem
mkdir -p public/episodios
touch public/episodios/.gitkeep

# Regras para o .gitignore
GITIGNORE_BLOCK=$(cat <<EOF

# Ignorar vídeos da pasta public/episodios
/public/episodios/*
!public/episodios/.gitkeep
EOF
)

# Adicionar regras ao .gitignore se ainda não estiverem lá
if ! grep -q "/public/episodios/*" .gitignore; then
  echo "$GITIGNORE_BLOCK" >> .gitignore
  echo "Regras adicionadas ao .gitignore."
else
  echo "As regras já existem no .gitignore."
fi

# Remover vídeos do Git (mas manter localmente)
git rm --cached public/episodios/* 2>/dev/null
echo "Arquivos removidos do controle de versão (se havia algum)."

# Commit das alterações
git add .gitignore public/episodios/.gitkeep
git commit -m "Ignorar vídeos da pasta public/episodios e manter .gitkeep" || echo "Nada para commitar."

echo "✔️ Configuração concluída."
