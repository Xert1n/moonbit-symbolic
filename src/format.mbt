/// 将表达式格式化为可读字符串
pub fn Expr::to_string(self : Expr) -> String {
  match self {
    Constant(n) => if n == n.floor() { n.to_int().to_string() } else { n.to_string() }
    Variable(name) => name
    Add(a, b) => "\(a.to_string()) + \(b.to_string())"
    Sub(a, b) => "\(a.to_string()) - \(b.to_string())"
    Mul(a, b) => "\(a.to_string()) * \(b.to_string())"
    Div(a, b) => "\(a.to_string()) / \(b.to_string())"
    Pow(a, b) => "\(a.to_string())^\(b.to_string())"
    Sin(a) => "sin(\(a.to_string()))"
    Cos(a) => "cos(\(a.to_string()))"
    Tan(a) => "tan(\(a.to_string()))"
    Exp(a) => "exp(\(a.to_string()))"
    Log(a) => "ln(\(a.to_string()))"
    Neg(a) => "-\(a.to_string())"
  }
}