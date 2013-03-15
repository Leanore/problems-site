CKEDITOR.editorConfig = function( config )
{
    config.toolbar = 'Easy';

    config.toolbar_Easy =
        [
            ['Bold','Italic','Strike'],
            ['BulletedList','NumberedList','Blockquote'],
            ['JustifyLeft','JustifyCenter','JustifyRight'],
            ['Link','Unlink'],
            ['Subscript', 'Superscript'],
            ['Image', 'Attachment', 'Flash', 'Embed'],
            ['YahooMaps', 'Dictionary'],
            '/',
            ['Format'],
            ['Underline', 'JustifyBlock', 'TextColor'],
            ['PasteText','PasteFromWord','RemoveFormat'],
            ['SpecialChar'],
            ['Outdent','Indent'],
            ['Undo','Redo'],
            ['Source']
        ];
}
