import 'models.dart';

final departments = <Department>[
  Department(id: 1, name: 'قسم التبريد', description: 'أساسيات ونظم التبريد'),
  Department(id: 2, name: 'قسم التكييف', description: 'أنظمة HVAC'),
  Department(id: 3, name: 'قسم الغسالات', description: 'صيانة الغسالات الأوتوماتيك'),
  Department(id: 4, name: 'قسم الميكروويف', description: 'تشخيص الميكروويف'),
  Department(id: 5, name: 'قسم السخانات', description: 'صيانة السخانات'),
];

final courses = <Course>[
  Course(id: 1, departmentId: 1, title: 'أساسيات التبريد', level: 'مبتدئ', duration: 24, rating: 4.6, trainer: 'م. أحمد سامي', summary: 'مبادئ حرارية ودورة التبريد.'),
  Course(id: 2, departmentId: 2, title: 'صيانة مكيفات الهواء', level: 'متوسط', duration: 32, rating: 4.3, trainer: 'م. سارة علي', summary: 'تشخيص أعطال وحدات السبليت.'),
  Course(id: 3, departmentId: 3, title: 'احتراف إصلاح الغسالات', level: 'متقدم', duration: 28, rating: 4.8, trainer: 'م. محمد فوزي', summary: 'أعطال اللوحات والتحكم.'),
];

final trainees = <Trainee>[
  Trainee(id: 1, fullName: 'محمود السيد', email: 'mahmoud@example.com', nationalId: '29801010123456', departmentId: 1),
  Trainee(id: 2, fullName: 'آية عماد', email: 'aya@example.com', nationalId: '30105051234567', departmentId: 2),
];

final models = <DeviceModel>[
  DeviceModel(id: 1, departmentId: 3, name: 'Washer X200'),
  DeviceModel(id: 2, departmentId: 2, name: 'AC Split 1.5HP'),
  DeviceModel(id: 3, departmentId: 4, name: 'Microwave M900'),
];

final errorCodes = <ErrorCode>[
  ErrorCode(id: 1, departmentId: 3, code: 'E3', description: 'مشكلة صرف مياه', resolution: 'تنظيف الفلتر/مضخة الصرف وفحص الهوز.'),
  ErrorCode(id: 2, departmentId: 2, code: 'F0', description: 'نقص فريون', resolution: 'فحص التسريب وإعادة الشحن.'),
  ErrorCode(id: 3, departmentId: 4, code: 'H1', description: 'عطل مغنترون', resolution: 'قياس الدايود والكابستور واستبدال المتضرر.'),
];

final materialsDocs = <MaterialDoc>[
  MaterialDoc(id: 1, courseId: 3, title: 'كتيب أعطال الغسالات', type: 'handbook', url: 'handbook_washers.pdf'),
  MaterialDoc(id: 2, courseId: 2, title: 'دليل تركيب مكيف', type: 'guide', url: 'install_ac.pdf'),
];

final chatSeed = <ChatMessage>[
  ChatMessage(id: 1, from: 'expert', text: 'مرحبًا، كيف أقدر أساعدك؟', at: DateTime.now()),
];
