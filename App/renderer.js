/** Para iniciarmos os trabalhos vamos colocar as lógicas do App
 *  dentro do arquivo renderer.js.
 *  Para Ilustrar estamos colocando a logica de click do botão que será gerado
 *  na estrutrua do projeto criado pelo script sheel
  */

const elementButtonAlert = document.getElementById('id-button-alert');
elementButtonAlert.addEventListener('click', () => {
  alert('comecei a fazer graça')
})
