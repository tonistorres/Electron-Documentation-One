#! /usr/bin/zsh
source ./gitconfigurations.sh  #CREATOR GITIGNORE

MENU="
-----------------------------------------
Create Folder .vscode how to SheelScript
-----------------------------------------
"
TIME(){
echo "2s"
sleep 1
echo "1s"
sleep 1
}



CONTENT_VSCODE_INITIAL_CONFIGURATIONS(){

cat << EOF > settings.json
{
  "editor.fontSize": 18,
  "editor.minimap.enabled": false,
  "window.zoomLevel": 1,
  "editor.wordWrap": "on"
}
EOF
}

CREATE_FILE_README(){
touch README.md
}

CREATE_FOLDER_VSCODE(){
mkdir .vscode
cd .vscode
touch settings.json
CONTENT_VSCODE_INITIAL_CONFIGURATIONS
CREATE_FILE_README
cd ..
}

CREATE_STRUCTURE_INITIAL_IN_PROJECT(){
touch index.html
touch main.js
touch preload.js
touch renderer.js
touch styles.css
}


CREATOR_FILE_GITIGNORE(){
cat << EOF >> .gitignore
node_modules/
out/
EOF
}

CREATE_STRUCTURE(){
  touch .gitignore
  CREATOR_FILE_GITIGNORE
}


INITIAL_APP_NPM_INIT(){
  npm init
}


INSTALL_ELECTRON(){
npm install electron --save-dev
}

CREATE_FOLDER_APP(){
mkdir App
cd App
CREATE_STRUCTURE_INITIAL_IN_PROJECT
CREATE_STRUCTURE # criando .gitignore dentro de App
INITIAL_APP_NPM_INIT # criando o arquivo package.json que conterá as dependências de desenvolvimento do projeto
INSTALL_ELECTRON # instalando o framework Electron
}



EXECUTE(){
  echo "$MENU"
  TIME
  CREATE_FOLDER_VSCODE # root project
  CREATE_STRUCTURE # create structure gitignore
  CREATE_FOLDER_APP # Neste Ponto Estou Dentro da Pasta App

}


EXECUTE
