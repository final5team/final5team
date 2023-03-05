tinymce.init({
	language: 'ko_KR',
	selector: '#reply',
	height: '100mm',
	theme: 'silver',
	menubar: false,
	plugins: [
	    'print noneditable save',
	    'wordcount fullscreen charmap hr textcolor colorpicker textpattern',
	    'template searchreplace insertdatetime pagebreak emoticons'
	],
	toolbar2: 'undo redo | insert | styleselect | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent',
	template_mdate_format: '%m/%d/%Y : %H:%M',
	save_enablewhendirty: false,
	object_resizing : false,
	forced_root_block : ""
});

tinymce.init({
	language: 'ko_KR',
	selector: '#document_detail',
	height: '297mm',
	theme: 'silver',
	plugins: [
		'noneditable'
		],
	menubar : '',
	toolbar1: 'fullscreen print preview wordcount',
	readonly: 1,
	content_css : '../resources/css/approvalform.css',
	object_resizing : false
});