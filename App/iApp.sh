# Utilizado para empacotas a aplicação e criar o executável
# para os 03(tres) principais Sistemas Operacionais (Windows, Distro Linux e MacOS)
# https://www.npmjs.com/package/electron-packager?activeTab=readme
INSTALL_ELECTRON_PACKAGER_G(){
npm i electron-packager -g
}

ADDING_STRUCTURE_INITIAL_FILE_HTML(){
cat << EOF >> index.html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <!-- https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP -->
    <meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self'">
    <title>Hello World!</title>
  </head>
  <body>
    <h1>Hello World!</h1>
    We are using Node.js <span id="node-version"></span>,
    Chromium <span id="chrome-version"></span>,
    and Electron <span id="electron-version"></span>.
  </body>
</html>
EOF
}

ADDING_STRUCTURE_INITIAL_MAINJS(){
cat << EOF >> main.js
/**

O módulo app, que controla os eventos do ciclo de vida de sua aplicação.
O módulo BrowserWindow, que cria e gerencia as janelas da sua aplicação.
Pelo fato do processo principal ser executado em Node.js, você pode importá-los como módulos CommonJS no topo de seu arquivo:

*/
const { app, BrowserWindow } = require('electron');
const path = require('path');
/**Criamos a função que irá criar a Janela Principal do Sistema */
function createWindowMain() {
  let windowMain = new BrowserWindow({
    width: 800,
    height: 600,
         /**
     * Os scripts de pré-carregamento contêm código que é executado em um processo de renderizador antes que seu conteúdo da Web comece a ser carregado. Esses scripts são executados no contexto do renderizador, mas recebem mais privilégios por terem acesso às APIs do Node.js.
      Um script de pré-carregamento pode ser anexado ao processo principal na opção BrowserWindowdo construtor webPreferences.
      Para anexar esse script ao processo do renderizador, passe o caminho para o script de pré-carregamento para a webPreferences.preloadopção no BrowserWindowconstrutor existente.
     * */

    webPreferences: {
      preload: path.join(__dirname, 'preload.js')
    }
  });

  /** Então, adicione a função createWindow() que carregará o arquivo index.html em uma nova instância do BrowserWindow.*/
  windowMain.loadFile('index.html');

  /** Abrindo o inspetor de código para verificar possíveis erros */
  windowMain.webContents.openDevTools();

}

/**No Electron, janelas do navegador só podem ser criadas após o módulo app disparar o evento ready. Você pode esperar por este evento utilizando a API app.whenReady(). Chame a função createWindow() após whenReady() resolver a Promise.*/
app.whenReady().then(createWindowMain);


/**
Gerencie o ciclo de vida de sua janela
Embora agora você possa abrir uma janela do navegador, precisará de algum código clichê adicional para torná-lo mais nativo para cada plataforma. As janelas do aplicativo se comportam de maneira diferente em cada sistema operacional, e a Electron atribui aos desenvolvedores a responsabilidade de implementar essas convenções em seu aplicativo.

Em geral, você pode usar o atributo processglobal platformpara executar código especificamente para determinados sistemas operacionais.

Encerrar a aplicação quando todas as janelas estiverem fechadas (Windows e Linux)
No Windows e no Linux, fechar todas as janelas geralmente encerra totalmente a aplicação.

Para implementar isso, ouça o evento appdo módulo 'window-all-closed'e chame app.quit()se o usuário não estiver no macOS ( darwin)
 */
app.on('window-all-closed', function () {
  if (process.platform === 'darwin') {
    app.quit();
  }
});

/**
 * Abra uma janela se nenhuma estiver aberta (macOS
Enquanto os aplicativos do Linux e do Windows são encerrados quando não há janelas abertas, os aplicativos do macOS geralmente continuam em execução mesmo sem nenhuma janela aberta, e ativar o aplicativo quando não há janelas disponíveis deve abrir um novo.

Para implementar esse recurso, ouça o evento appdo módulo activatee chame seu createWindow()método existente se nenhuma janela do navegador estiver aberta.

Como as janelas não podem ser criadas antes do readyevento, você só deve ouvir activateeventos depois que seu aplicativo for inicializado. Faça isso anexando seu ouvinte de evento de dentro de seu whenReady()retorno de chamada existente.

 */
app.on('activate', function(){
  if(BrowserWindow.getAllWindows().length === 0){
      createWindowMain();
  }
})
EOF
}


ADDING_STRUCTURE_INITIAL_FILE_PRELOADJS(){
cat << EOF >> preload.js
/**
 *É aqui que anexar um script de pré-carregamento ao seu renderizador é útil. Um script de pré-carregamento é executado antes que o processo do renderizador seja carregado e tem acesso aos globais do renderizador (por exemplo, windowe document) e a um ambiente Node.js.
 Resumo: Todos procedimento de lógica que você precisa para carregar a página web coloque aqui.
 */
window.addEventListener('DOMContentLoaded', () => {

  const replaceText = (selector, text) => {
    const element = document.getElementById(selector)
    if (element) element.innerText = text
  }

  for (const dependency of ['chrome', 'node', 'electron']) {
    replaceText(`${dependency}-version`, process.versions[dependency])
  }
})

EOF
}


EXECUTE(){
ADDING_STRUCTURE_INITIAL_FILE_HTML
ADDING_STRUCTURE_INITIAL_MAINJS
ADDING_STRUCTURE_INITIAL_FILE_PRELOADJS
}

EXECUTE
