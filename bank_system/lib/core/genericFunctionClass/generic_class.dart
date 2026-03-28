// نستخدم <T extends num> لنجعل الكلاس يعمل مع int و double فقط
class Calculator<T extends num> {
  
  // 1. الخصائص (Properties) من نوع T
  final T operand1;
  final T operand2;

  // Constructor لاستقبال القيم من نوع T
  Calculator(this.operand1, this.operand2);

  // 2. دوال تعيد القيمة من نفس نوع T
  // نستخدم 'as T' لنخبر Dart أن الناتج يجب أن يكون من نفس نوع المدخلات
  T add() {
    return (operand1 + operand2) as T;
  }

  T subtract() {
    return (operand1 - operand2) as T;
  }

  T multiply() {
    return (operand1 * operand2) as T;
  }

  // 3. دالة تعيد نوعاً مختلفاً (double) لأن القسمة دائماً عشرية
  double divide() {
    if (operand2 == 0) {
      throw Exception("خطأ: لا يمكن القسمة على صفر!");
    }
    return operand1 / operand2;
  }

  // 4. دالة عرض البيانات (Utility)
  void printResults() {
    print("\n--- نتائج العمليات لنوع البيانات: ${T} ---");
    print("$operand1 + $operand2 = ${add()}");
    print("$operand1 * $operand2 = ${multiply()}");
    print("$operand1 / $operand2 = ${divide()}");
  }
}

// void main() {
//   // تجربة مع int (مبالغ صحيحة)
//   var intCalc = Calculator<int>(20, 10);
//   intCalc.printResults();

//   // تجربة مع double (أسعار صرف عملات)
//   var doubleCalc = Calculator<double>(15.5, 2.5);
//   doubleCalc.printResults();
// }

//==========================================================//

// بما أنك مهندس طموح، فهذه هي "الضربة القاضية" في الـ OOP. فكرة الـ Generic Repository هي كتابة كلاس واحد يحتوي على عمليات (إضافة، حذف، بحث) لكل أنواع البيانات في مشروعك.

// بدلاً من كتابة CurrencyRepos و UserRepos و ClientRepos بشكل منفصل، سنصنع Template Class واحد يدير الجميع.

// 🛠️ كود الـ Generic Repository (المستوى المتقدم)
// لتحقيق هذا، سنستخدم واجهة (Interface) تسمى HasId لضمان أن أي كائن نمرره للكلاس يمتلك خاصية البحث.

// 1. واجهة عامة تضمن أن كل موديل له كود فريد
abstract class BaseData {
  String get id;
}

// 2. الـ Template Class (Generic Repository)
class GenericRepository<T extends BaseData> {
  // قائمة مخزنة في الذاكرة (Cache)
  final List<T> _dataList = [];

  // إضافة كائن جديد
  void add(T item) {
    _dataList.add(item);
    print("✅ تم إضافة عنصر جديد لنظام: ${T.toString()}");
  }

  // بحث عام عن طريق الـ ID
  T? find(String id) {
    try {
      return _dataList.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  // عرض كل البيانات
  List<T> getAll() => _dataList;
}

// 🚀 كيف نربط هذا بمشروع البنك الخاص بك؟
// لنفترض أنك تريد استخدامه للعملات، ستحتاج فقط لتعديل الـ CurrencyModel ليتبع الـ BaseData:

// تعديل الموديل ليصبح متوافقاً مع الـ Generic Repo
class CurrencyModel extends BaseData {
  final String currencyCode;
  final double rate;

  CurrencyModel({required this.currencyCode, required this.rate});

  @override
  String get id => currencyCode; // هنا نحدد أن الـ ID هو الكود
}

void main() {
  // الآن يمكنك إنشاء مستودع للعملات بضغطة زر!
  var currencyRepo = GenericRepository<CurrencyModel>();
  
  currencyRepo.add(CurrencyModel(currencyCode: "USD", rate: 1.0));
  currencyRepo.add(CurrencyModel(currencyCode: "YER", rate: 1650.0));

  // البحث
  var result = currencyRepo.find("YER");
  print("العملة المكتشفة: ${result?.currencyCode}, السعر: ${result?.rate}");
}


