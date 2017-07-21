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
```

### オプション
- Objective-Cにはなかった概念
- `nullpointer` ではないので注意
- 特定の値が存在しない事

``` swift
var a: Int? = 1
a = nil
assert(a?.bigEndian == nil)
if a != nil {
  print(a!.bigEndian) // 強制アンラップ
}

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
