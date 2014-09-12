(function($) {
    $(document).ready(function() {
        try {
            var recognition = new webkitSpeechRecognition();
        } catch(e) {
            var recognition = Object;
        }

        var interimResult = '';
        var textArea = $('#result');

        recognition.continuous = true;
        recognition.interimResults = true;
        var recognizing = false;

        $('#toggle-asr').click(function(){
            if(recognizing) {
                recognition.stop();
                recognizing = false;
                $(this).removeClass('mic-red');
            } else {
                textArea.focus();
                recognition.start();
                recognizing = true;
                $(this).addClass('mic-red');
            }
        });

        recognition.onresult = function (event) {
            var pos = textArea.getCursorPosition() - interimResult.length;
            textArea.val(textArea.val().replace(interimResult, ''));
            interimResult = '';
            textArea.setCursorPosition(pos);
            for (var i = event.resultIndex; i < event.results.length; ++i) {
                if (event.results[i].isFinal) {
                    insertAtCaret('result', event.results[i][0].transcript);
                } else {
                    isFinished = false;
                    insertAtCaret('result', event.results[i][0].transcript + '\u200B');
                    interimResult += event.results[i][0].transcript + '\u200B';
                }
            }
        };

        recognition.onend = function() {
            $('#result').select();
        };
    });
})(jQuery);