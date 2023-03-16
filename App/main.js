// Documentation: https://www.electronjs.org/pt/docs/latest/tutorial/quick-start

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
     * */
    webPreferences: {
      preload: path.join(__dirname, 'preload.js')
    }
  });
  windowMain.loadFile('index.html');
}

/**
 * No Electron, janelas do navegador só podem ser criadas após o módulo app disparar o evento ready. Você pode esperar por este evento utilizando a API app.whenReady(). Chame a função createWindow() após whenReady() resolver a Promise.
 */
app.whenReady().then(createWindowMain);

/**
 * Encerrar a aplicação quando todas as janelas estiverem fechadas (Windows e Linux)
No Windows e no Linux, fechar todas as janelas geralmente encerra totalmente a aplicação.

Para implementar isso, ouça o evento appdo módulo 'window-all-closed'e chame app.quit()se o usuário não estiver no macOS ( darwin).  */
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
app.on('activate', function () {
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindowMain();
  }
})
