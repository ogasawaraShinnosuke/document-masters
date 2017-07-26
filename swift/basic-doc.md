# このドキュメントについて
- 当ドキュメントは恣意的に書かれております
- サンプルコードに関しては，`Apple Swift version 3.1`で動作確認をしているため，それ以外の動作保証はありません
- 公式の https://developer.apple.com/library/content/navigation/ を参照しています

## Swift
- iOS、macOS、watchOS、およびtvOSアプリケーション開発用の新しいプログラミング言語
- タイプセーフな言語，ただし，タイプ注釈はあまり書かない．型推論があるから

### 宣言
- 変数 `var`
- 定数 `let`
- 基本的には変更しないものは全て `let` で宣言する

### 型
- Int
- Float
- Double
- Bool
- String `let fuga = "fuga"; print("hoge \(fuga)")` hoge fugaと表示される
- Array
- Set
- Dictionary

### コメント

``` swift
// hoge

/* hoge
 fuga */
```

### 数値

#### Intの境界値

- -128 <= Int8 <= 127
- -32768 <= Int 16 <= 32767
- -2147483648 <= Int32 <= 2147483647
- -9223372036854775808 <= Int64, Int <= 9223372036854775807
- 0 <= UInt8 <= 255
- 0 <= UInt16 <= 65535
- 0 <= UInt32 <= 4294967295
- 0 <= UInt64, UInt <= 18446744073709551615

#### 内容
- 上記のように型は違えど，型推論により開発時に気にする必要はない．整数定数と変数がコード内ですぐに相互運用可能なので，Intを共通して使うのがよい．`9223372036854775807`より大きな数字を使いたくて，それが確実に非数ならUInt．
- 外部ソースからの明示的なサイズのデータ​​、またはパフォーマンス、メモリ使用量、またはその他の必要な最適化のため，必要なタスクに特に必要な場合にのみ使用すること
- 数値同士の演算で浮動小数点数の型推論はDouble型になるが，実際に型推論されたInt型との演算はできない

``` swift
let a = 40
assert(Double(a) + 3.13 == 43.13)
assert(40 + 3.13 == 43.13)
```

- 読みやすくするように以下のようにできる
``` swift
let a: UInt = 18_446_744_073_709_551_614
assert(a + 1 == 18446744073709551615)
```

### マップ
- `let`で宣言したら要素を追加することができない

``` swift
var cryptoCurrency = ["BTC": 3000, "XRP": 0.2, "XEM": 0.015]
assert(["BTC": 3000, "XRP": 0.2, "XEM": 0.015]==cryptoCurrency)
cryptoCurrency["ETH"] = 250
assert(["BTC": 3000, "XRP": 0.2, "XEM": 0.015, "ETH": 250]==cryptoCurrency)
```

### タプル
- 複数の値を単一の複合値にグループ化

``` swift
enum Age {
    case unknown
    case early_cretaceous
}
enum Foodness {
    case unknown
    case vegetable
}
let dinosaur1 = ("イグアノドン", 10, Age.early_cretaceous, Foodness.vegetable)
let (_, _, _, foodness) = dinosaur1 // foodnessだけが出力したい
assert(foodness == Foodness.vegetable)

// タプルに直接名前を付けても良い
let dinosaur2 = ("イグアノドン", 10, Age.early_cretaceous, foodness: Foodness.vegetable)
assert(dinosaur2.foodness == Foodness.vegetable)

// age, foodnessは任意指定
func getIguanodon(age: Age = Age.early_cretaceous, foodness: Foodness = Foodness.vegetable) -> (name: String, total_length: Int, age: Age, foodness: Foodness){
    return ("イグアノドン", 10, age, foodness)
}
```

### オプション
- Objective-Cにはなかった概念
- `nullpointer` ではないので注意
- 特定の値が存在しない事

``` swift
var a: Int? = 1
a = nil
assert(a?.bigEndian == nil)
let b = a != nil ? a!.bigEndian : 100 // 強制アンラップ
assert(b == 100)

// バインドすることでオプションの値チェックができる
if let b = a {
  print(b) // aがnilでないとき，強制アンラップが必要ない
} else {
  print(a) // aがnilのとき
}

// 暗黙的にアンラップされたオプション
let c: Int! = 1
print(c) // 都度アンラップする必要がないが，nilになる可能性があるなら暗黙化はやるべきではない
```

### レンジ演算子

``` swift
// クローズドレンジ
// 1〜10までループし，`i`には1〜10が代入される
for i in 1...10 {
  print(i)
}

// ハーフオープンレンジ
// 1〜9までループし，`i`には1〜9が代入される
for i in 1..<5 {
  print(i)
}
```

### 辞書型

``` swift
let crypto_currency: [String: String] = ["BitCoin": "BTC", "Ripple": "XRP"]
for (name, key) in crypto_currency {
  print("\(name) \(key)")
}
```

### Guard

``` swift
enum Status {
  case OK
  case NG
}

// `_`は引数ラベルを省略している
func a(_ b: String) -> String{
  guard Status.OK == b else {
    return "NG"
  }
  return "OK"
}
assert(a(Status.OK) == "OK")
```

### inout
- 関数パラメタはデフォルトが定数だが，それを変更可能にする時に使う
    - `inout` を型の前に付与して，呼び出す時に`&`を変数の前につける
- クラスのインスタンス，関数は参照型であり，それ以外はすべて値型となる
- [これで完結](https://stackoverflow.com/questions/27364117/is-swift-pass-by-value-or-pass-by-reference?answertab=votes#tab-top)

#### inoutの実態
- コピーインコピーアウト（値による呼び出し結果）
- 関数が呼び出されると，引数の「値」がコピーされる
- 関数の本体では，コピーが変更される
- 関数が戻ると，コピーの「値」が元の引数に代入される

#### 参照による呼び出し
- 引数が物理アドレスに格納されている場合，関数本体の内部と外部の両方で同じメモリが使用される

``` swift
func swapValues(_ a: inout Int, _ b: inout Int) {
  let t = a
  a = b
  b = t
}
var updA = 59
var updB = 1111
swapValues(&updA, &updB)
assert(updA == 1111)
assert(updB == 59)
```

##### クラスと構造体
- 構造体は何らかの変数等に代入されるとコピーだが，クラスは参照型である
- 多くのメンバ変数が必要とされる設計にするならクラスで実装するほうがよいし，単純なカプセル化の場合にstructにする感覚で，かつその値をコピーさせて使いたい

``` swift
// c1bはc1aからコピーされたものなので，変更しても互いは独立している
struct CryptoCurrency1 {
  var name: String
  var fullName: String
}
var c1a = CryptoCurrency1(name: "BTC", fullName: "BitCoin")
var c1b = c1a
c1b.name = "XRP"
c1b.fullName = "Ripple"
assert(c1a.name==c1b.name && c1a.fullName==c1b.fullName)

// c2aとc2bは参照型で同様の値を表しているため，互いの変更が互いに反映
class CryptoCurrency2 {
  var name: String
  var fullName: String
  init(name: String, fullName: String) {
    self.name = name
    self.fullName = fullName
  }
}
var c2a = CryptoCurrency2(name: "BTC", fullName: "BitCoin")
var c2b = c2a
c2b.name = "XRP"
c2b.fullName = "Ripple"
assert(c2a===c2b)
```

### クロージャ
- Java8以降のlambdaや，Cのブロックに似ている機能
- 関数とクロージャは参照型
- クロージャが呼び出されない場合、クロージャ内の式は評価されない
- 戻り値が曖昧な時は`return`が必要
- 型推論が効くなら省略可
- swiftによる推測記法がたくさんあるので，それをサンプルコードにした
- `@autoclosure @escaping`というものもある

``` swift
let values = [73,2,96,14,6,0,1,80]

// クロージャの書き方・基本
var a1 = values.sorted(by: { (v1: String, v2: String) -> Bool in return v1 < v2 })
assert(a1==[0, 1, 2, 6, 14, 73, 80, 96])

// クロージャの書き方・型推論
var a2 = values.sorted(by: { v1, v2 in v1 < v2 })
assert(a2==[0, 1, 2, 6, 14, 73, 80, 96])

// クロージャの書き方・簡略引数名
var a3 = values.sorted(by: { $0 < $1 })
assert(a3==[0, 1, 2, 6, 14, 73, 80, 96])

// クロージャの書き方・演算子メソッド
var a4 = values.sorted(by: <)
assert(a4==[0, 1, 2, 6, 14, 73, 80, 96])

// トレーリングクローズ
var a5 = values.sorted() { $0 < $1 }
assert(a5==[0, 1, 2, 6, 14, 73, 80, 96])
var a6 = values.sorted { $0 < $1 }
assert(a6==[0, 1, 2, 6, 14, 73, 80, 96])
```

### プロパティ
- ストアドプロパティは，特定のクラスや構造体のインスタンスの一部として格納される定数や変数のこと
- プロパティオブザーバは，`willSet`により値の格納直前に呼び出される処理を，`didSet`により新しい値が格納直後に呼び出される処理を定義できる

``` swift
class Position {
  var total: Int = 0 {

    // 値の格納直前に呼び出される
    willSet(newTotal) {
      print("I'm position is \(newTotal*2)")
    }

    // 新しい値が格納直後に呼び出される
    didSet {
      if total > oldValue {
        print("Nice \(total - oldValue)")
      }
    }
  }

  static var masterPosition = 1_000_000
}
let p = Position()
p.total = 5
p.total = 1
assert(Position.masterPosition == 1_000_000)
```

### 自己プロパティ
- 通常，構造型や列挙型は値型なので（クラス型は参照型）プロパティが変更不可
- 変更させるためには，`mutating`を使うこと

``` swift
struct CryptoCurrency {
  var name: String?, priceYen = 0

  // mutatingによりプロパティの変更が可能になる
  mutating func updatePriceYen(_ updateValue: Int) {
    priceYen = updateValue
  }
}
// 構造体なので，プロパティを変更するためにはletは使ってはいけない
var c = CryptoCurrency(name: "BTC", priceYen: 30)
assert(c.priceYen == 30)
c.updatePriceYen(31)
assert(c.priceYen == 31)

// 自転車のライト４段階
enum BikeLight {
  // 消灯，点灯，弱，点滅
  case off, up, weak, flashing
  mutating func press() {
    switch self {
      case .off:
        self = .up
      case .up:
        self = .weak
      case .weak:
        self = .flashing
      case .flashing:
        self = .off
    }
  }
}
var l = BikeLight.up
assert(BikeLight.up==l)
l.press()
assert(BikeLight.weak==l)
l.press()
assert(BikeLight.flashing==l)
l.press()
assert(BikeLight.off==l)
```

### 値型のイニシャライザ委任
- インスタンスの初期化の一部を委譲

``` swift
struct CryptoCurrency {
  var name: String
  var fullName: String
  init(name: String, fullName: String) {
    self.name = name
    self.fullName = fullName
  }
}
struct BitCoin {
  var c: CryptoCurrency
  init(_ c: CryptoCurrency) {
    self.c = c
  }
}
var b = BitCoin(CryptoCurrency(name: "BTC", fullName: "BitCoin"))
```

### クラス型のイニシャライザ委譲
- ルール
    - 指定イニシャライザは，スーパークラスから指定されたイニシャライザを呼ぶ
    - `convenience`が同じクラスの別の初期化子を呼ぶ
    - `convenience`が最終的に指定されたイニシャライザを呼ぶ
- サブクラスは，デフォルトでスーパークラス初期化子を継承しない
- 継承はコマンドラインでやってるとそれぞれが独立しているためエラーになるので注意

``` swift
class Animal {
    var name: String
    required init(_ name: String) {
        self.name = name
    }

    // 別のinitを呼ぶ
    convenience init() {
        self.init("animal")
    }
    func cry() -> String {
        return "\(name) gya-gya-"
    }
}

class Cat: Animal {

    // 親の最終的に指定されたイニシャライザを呼ぶ
    required init(_ name: String) {
        super.init(name)
    }

    // 別のinitを呼ぶ
    convenience init() {
        self.init("cat")
    }
    override func cry() -> String {
        return "\(name) mya-mya-"
    }
}

var c = Cat("mike")
assert("mike mya-mya-"==c.cry())
```

### 初期化解除
- deinitializerは，クラスインスタンスの割当が解除される直前に呼び出される