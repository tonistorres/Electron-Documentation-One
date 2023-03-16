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
