/// 符号表达式类型
pub enum Expr {
  Constant(Double)                  // 数值常量
  Variable(String)                  // 变量（如 x, y）
  Add(Expr, Expr)                   // 加法
  Sub(Expr, Expr)                   // 减法
  Mul(Expr, Expr)                   // 乘法
  Div(Expr, Expr)                   // 除法
  Pow(Expr, Expr)                   // 幂运算
  Sin(Expr)
  Cos(Expr)
  Tan(Expr)
  Exp(Expr)                         // e^x
  Log(Expr)                         // 自然对数
  Neg(Expr)                         // 一元负号
}

/// 快捷构造子
pub fn constant(n : Double) -> Expr { Constant(n) }
pub fn variable(name : String) -> Expr { Variable(name) }
pub fn add(a : Expr, b : Expr) -> Expr { Add(a, b) }
pub fn mul(a : Expr, b : Expr) -> Expr { Mul(a, b) }
pub fn pow(base : Expr, exp : Expr) -> Expr { Pow(base, exp) }

/// 表达式相等性（结构相等，不做代数等价判断）
pub fn Expr::equals(self : Expr, other : Expr) -> Bool {
  match (self, other) {
    (Constant(a), Constant(b)) => a == b
    (Variable(a), Variable(b)) => a == b
    (Add(a1, a2), Add(b1, b2)) => a1.equals(b1) && a2.equals(b2)
    (Sub(a1, a2), Sub(b1, b2)) => a1.equals(b1) && a2.equals(b2)
    (Mul(a1, a2), Mul(b1, b2)) => a1.equals(b1) && a2.equals(b2)
    (Div(a1, a2), Div(b1, b2)) => a1.equals(b1) && a2.equals(b2)
    (Pow(a1, a2), Pow(b1, b2)) => a1.equals(b1) && a2.equals(b2)
    (Sin(a), Sin(b)) => a.equals(b)
    (Cos(a), Cos(b)) => a.equals(b)
    (Tan(a), Tan(b)) => a.equals(b)
    (Exp(a), Exp(b)) => a.equals(b)
    (Log(a), Log(b)) => a.equals(b)
    (Neg(a), Neg(b)) => a.equals(b)
    _ => false
  }
}