import 'package:motifnesia_mobile/shared/forms/form_view.dart';

const securityQuestionField = FormFieldSpec(
  'secret_question',
  'Pertanyaan keamanan',
  kind: FieldKind.choice,
  options: {
    'makanan': 'Makanan favorit Anda?',
    'hewan': 'Hewan peliharaan pertama Anda?',
    'hobi': 'Apa hobi favorit Anda?',
  },
);
const securityAnswerField = FormFieldSpec('secret_answer', 'Jawaban keamanan');
