tinymce.init({
selector: '#tinyMceExample',
width: '210mm',
height: '297mm',
theme: 'silver',
plugins: [
    'advlist autolink lists link image charmap print preview hr anchor pagebreak',
    'searchreplace wordcount visualblocks visualchars code fullscreen',
    'insertdatetime media nonbreaking save table contextmenu directionality',
    'emoticons template paste textcolor colorpicker textpattern imagetools codesample toc help'
],
toolbar1: 'undo redo | insert | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image',
toolbar2: 'print preview media | forecolor backcolor emoticons | codesample help',
image_advtab: true,
template_mdate_format: '%m/%d/%Y : %H:%M',
templates : [
  {
    title: '결재품의서',
    description: '모든 품의서의 템플릿인 결재품의서',
    url: '../resources/html/extraworkform.html'
  },
  {
    title: 'Replace values example',
    description: 'These values will be replaced when the template is inserted into the editor content.',
    content: '<p>Name: {$username}, StaffID: {$staffid}</p>'
  }
],
content_style: '.td { padding: 0; }'
});