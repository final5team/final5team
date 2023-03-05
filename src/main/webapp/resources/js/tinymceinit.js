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
	selector: 'textarea.pmcontent',
	height: '70mm',
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