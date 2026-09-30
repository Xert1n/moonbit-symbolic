/// 递归化简表达式
pub fn simplify(expr : Expr) -> Expr {
  match expr {
    Constant(_) | Variable(_) => expr

    Add(a, b) => {
      let sa = simplify(a)
      let sb = simplify(b)
      match (sa, sb) {
        // 0 + x = x
        (Constant(0.0), _) => sb
        // x + 0 = x
        (_, Constant(0.0)) => sa
        // 常数折叠
        (Constant(x), Constant(y)) => Constant(x + y)
        // 合并同类项: x + x = 2x
        _ if sa.equals(sb) => simplify(Mul(Constant(2.0), sa))
        _ => Add(sa, sb)
      }
    }

    Sub(a, b) => {
      let sa = simplify(a)
      let sb = simplify(b)
      match (sa, sb) {
        (_, Constant(0.0)) => sa
        (Constant(x), Constant(y)) => Constant(x - y)
        // x - x = 0
        _ if sa.equals(sb) => Constant(0.0)
        _ => Sub(sa, sb)
      }
    }

    Mul(a, b) => {
      let sa = simplify(a)
      let sb = simplify(b)
      match (sa, sb) {
        // 0 * x = 0
        (Constant(0.0), _) | (_, Constant(0.0)) => Constant(0.0)
        // 1 * x = x
        (Constant(1.0), _) => sb
        (_, Constant(1.0)) => sa
        // 常数折叠
        (Constant(x), Constant(y)) => Constant(x * y)
        // x * x = x^2
        _ if sa.equals(sb) => simplify(Pow(sa, Constant(2.0)))
        _ => Mul(sa, sb)
      }
    }

    Div(a, b) => {
      let sa = simplify(a)
      let sb = simplify(b)
      match (sa, sb) {
        (Constant(0.0), _) => Constant(0.0)
        (_, Constant(1.0)) => sa
        (Constant(x), Constant(y)) => if y != 0.0 { Constant(x / y) } else { Div(sa, sb) }
        _ if sa.equals(sb) => Constant(1.0)
        _ => Div(sa, sb)
      }
    }

    Pow(a, b) => {
      let sa = simplify(a)
      let sb = simplify(b)
      match (sa, sb) {
        (_, Constant(0.0)) => Constant(1.0)
        (_, Constant(1.0)) => sa
        (Constant(x), Constant(y)) => Constant(x.pow(y))
        _ => Pow(sa, sb)
      }
    }

    Neg(a) => {
      let sa = simplify(a)
      match sa {
        Constant(x) => Constant(-x)
        Neg(inner) => inner  // -(-x) = x
        _ => Neg(sa)
      }
    }

    Sin(a) => {
      let sa = simplify(a)
      match sa {
        Constant(0.0) => Constant(0.0)
        _ => Sin(sa)
      }
    }

    Cos(a) => {
      let sa = simplify(a)
      match sa {
        Constant(0.0) => Constant(1.0)
        _ => Cos(sa)
      }
    }

    Tan(a) => Tan(simplify(a))
    Exp(a) => {
      let sa = simplify(a)
      match sa {
        Constant(0.0) => Constant(1.0)
        _ => Exp(sa)
      }
    }
    Log(a) => {
      let sa = simplify(a)
      match sa {
        Constant(1.0) => Constant(0.0)
        _ => Log(sa)
      }
    }
  }
}