/// 符号计算公共 API

/// 化简表达式
pub fn simplify(expr : Expr) -> Expr { @simplify.simplify(expr) }

/// 符号求导
pub fn diff(expr : Expr, var_name : String) -> Expr { @diff.diff(expr, var_name) }

/// 符号积分
pub fn integrate(expr : Expr, var_name : String) -> Expr raise SymbolicError {
  @integrate.integrate(expr, var_name)
}