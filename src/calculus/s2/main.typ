#import "template.typ": *

#set page(margin: 0.55in)
#set par(leading: 0.55em, first-line-indent: 0em, justify: false)
#set text(font: "New Computer Modern")
#set heading(numbering: "1.1.")
#show raw: set text(font: "New Computer Modern Mono")
#show par: set block(spacing: 0.55em)
#show heading: set block(above: 1.4em, below: 1em)
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set text(1.44em)
#show outline.entry.where(
  level: 1
): it => {
  v(15pt, weak: true)
  text(weight: "bold", size: 1.35em, it)
  
}

#show: project.with(
  title: "Математический анализ\nII семестр",
  authors: (
    "_scarleteagle",
    "imkochelorov"
  ),
  date: "зима/весна 2024",
  subtitle: "Лектор: Кохась Константин Петрович"
)

#let def = strong("Определение:")
#let dp(first, second)=$angle.l #first, #second angle.r$
#let sum=$limits(sum)$
#let lim=$limits(lim)$
#let proof=par(strong("Доказательство:"))
#let th=strong("Теорема:")
#let lm=strong("Лемма:")
#let defnot = strong("Обозначение:")
#let int=$limits(integral)$
#let qed=$space qed$
#let note=strong("Замечание:")
#let cor(..number)= {
  if number.pos().len() == 0 {
    strong("Следствие:")
  }
  else {
    strong("Следствие " + str(number.pos().at(0)) + ":")
  }
}
#let limsup = $overline(lim)$
#let liminf = $underline(lim)$
#let smile = emoji.face.smile.slight
#let frown = emoji.face.frown.slight

#outline(title: "Оглавление", indent: auto)

#pagebreak()

= Неопределённый интеграл

#def _первообразная_\ $F, f: dp(a, b) -> RR$\
$F$ --- _первообразная_ $f$, если $forall x in dp(a, b) quad F'(x)=f(x)$
\ \
#th $f$ --- непр на $dp(a, b) => exists$ пер-я $f$
\
#proof
Чуть позже.
\ \
#th $F$ --- пер-я $f$ на $dp(a, b) =>$
- $forall c in RR quad F+c$ --- пер-я $f$
- $G$ --- пер-я $f => exists c in RR: G-F=c$
#proof
- $(F+c)' = f$
- $(G-F)' = f - f = 0 => G-F = "const"$
\ 
#def _неопределённый интеграл_ \
_Неопределённый интеграл_ функции $f$ на $dp(a, b)$ --- мн-во всех первообразных $={F+c, c in RR, f "- пер-я"}$
\  \
#defnot $int f, int f(x) dif x$

\
*Примеры*:
- $int 1/(x+a^2) dif x = ln abs(x+a^2) + C$ 

- $int 1/x dif x = ln abs(x) + C$
- $int 1/(x^2+1) dif x = arctan x$
- $int 1/(x^2-1) dif x = 1/2 ln((x-1)/(x+1))$ #emoji.face.frown.slight
- $int 1/(sqrt(1-x^2) dif x) = arcsin x$
- $int 1/(sqrt(1+x^2)) = ln abs(x + sqrt(x^2 + 1))$

\
#th _о свойствах неопределённого интеграла_\
Пусть $f, g$ имеют пер-е на $dp(a, b) =>$
- $int f+g=int f + int g$

- $forall alpha in RR quad int alpha f = alpha int f$
- Замена переменной: $phi: dp(c, d) -> dp(a, b)$ дифф $=> int f(phi(t)) phi' dif t = (int f(x) dif x bar_(x=phi(t))) = int f(phi(t)) dif phi(t)$
  - Можо читать справа налево: $F(phi(t)) = h(t) => x=phi(t) => t = phi^(-1) (x)$
- $forall alpha, beta in RR, alpha != 0 quad int f(alpha x + beta) dif x = 1/alpha F(alpha x + beta)$
#proof
- Тривиально.

- Тривиально.
- $F$ --- пер-я $f => int f(phi(t)) phi'(t)=F(phi(t))$
- Частный случай предыдущего пункта.
\
Пример: $int (dif x)/(sqrt(x^2 + 16)) = 1/4 (dif x)/(sqrt(x^2/16+1))=1/4 int (dif x)/(sqrt((x/4)^2 + 1)) = 1/(1 slash 4) 1/4 ln abs(x/4 +sqrt(x^2/16 + 1))$

#th $f, g$ дифф на $dp(a, b), f'g$ имеет пер-ю на $dp(a, b)=> g'f$ имеет пер-ю на $dp(a, b)$ и $int f g' = f g - int f'g$
\ \
#proof
$(f g - int f'g)' = f'g + f g' - f'g = f g'$
\ \
*Пример:*

\
$int sqrt(1 - x^2) dif x =^(???)_(quad quad space x=sin t\ [-1, 1] <-> [-pi/2, pi/2]) int sqrt(1-sin^2 t) cos t dif t = int cos^2 t dif t = int 1/2 + (cos 2t)/2 dif t = 1/2 t + 1/4 sin 2t=$$=1/2 arcsin x + 1/4 sin(2 arcsin x)=1/2 arcsin x + 1/2 x sqrt(1-x^2)$
\
\
#quote("Если у вас что-то такое в уме - изгоните немедленно!", attribution: "КПК", block: true)

= Определённый интеграл
#def _плоская фигура_\  
_Плоская фигура_ --- огр. подмн-во $RR^2$
\ \
#def _множество плоских фигур_\
$cal(E)$ = мн-во плоских фигур\ \
#def _площадь_\
_Площадь_ --- функция $sigma: cal(E) -> [0, +infinity)$:
- Аддитивность: $A_1, A_2 in cal(E) quad A= A_1 union.sq A_2 quad sigma A = sigma A_1 + sigma A_2$

- Нормировка: $sigma(dp(a, b) times dp(c, d)) = (b - a)(d-c)$ _(площадь прямоугольника)_
\
*Новости* (хорошая и странная): \ Площади существуют, площадей много.
\ \
#note
- $sigma$ монотонна: $A, B in cal(E), A subset B => sigma A <= sigma B$

- $sigma ("верт. отрезка")=0$
\
#def _ослабленная площадь_\
_Ослабленная площадь_ $sigma: cal(E)-> [0, +infinity)$:
- $sigma$ монотонна

- Нормировка
- Ослабленная аддитивность: $E in cal(E) quad E=E_1 union E_2$ (разбиение верт. отрезком) $=> sigma E=sigma E_1 + sigma E_2$

\
*Новости* (хорошие и странные):\ Ослабленные площади существуют, ослабленных площадей много
\ \
*Пример:*\ $sigma_1 E = inf {sum sigma(P_k): E subset limits(union.big)_"кон." P_k}$\ \
$sigma_2 E = inf {sum sigma(P_k): E subset limits(union.big)_"счётн." P_k}$
\ \
$sigma_1([0, 1]^2 sect (QQ times QQ))=1$\
$sigma_2([0, 1]^2 sect (QQ times QQ))=sigma_2(limits(union.big)_(k=1)^(+infinity) {P(x_k)}), P(x_k) = [x^k_1 - epsilon/sqrt(2^k), x^k_1 + epsilon/sqrt(2^k)] times [x^k_2 - epsilon/sqrt(2^k), x^k_2 + epsilon/sqrt(2^k)]$\
$=> sigma_2([0, 1]^2 sect (QQ times QQ))=0$

$sigma_1$ и $sigma_2$ различаются только в патологических случаях. Для подграфиков непрерывных ф-ций они дают одно и то же.
\ \
#def _положительная срезка_\
Положительная срезка $f$: $f^+=max(f, 0)$. Отрицательная срезка $f$: $f^-=max(-f, 0)$.
\ \
#note \ 
$f=f^+-f^-$\ $abs(f)=f^++f^-$
\ \
#def _подграфик функции_\ $f>=0$ на $[a, b], E subset [a, b]$. _Подграфик ф-ции $f$ на мн-ве_ $E$ $"ПГ"(f, E)=$$={(x, y) in RR^2: x in E, 0 <= y <= f(x)}$
\ \
#def _определённый интеграл_\ Определённый интеграл функции $f$ на $[a, b]$ $int_a^b f = sigma("ПГ"(f^+, [a, b])) - sigma("ПГ"(f^-, [a, b]))$
\ \

== Свойства
#note\ Далее считаем $f in C([a, b])$ \
\
#note 
- $f >= 0 => int_a^b f >= 0$

- $f equiv c quad int_a^b f = c (b - a)$ #emoji.face.smile.slight 
- $int_a^b (-f) = -int_a^b f$
- при $a = b quad int_a^b = 0$ 
\
*Свойство 1:* _аддитивность по промежутку_\ \ $forall c in [a, b] int _a^b = int_a^c f + int _c^b f$\ \
*Свойство 2.* _монотонность_\ \
$f, g in C([a, b]), f <= g => int_a^b f <= int_a^b g$
\ \
#proof
$f <= g => f^+ <= g^+, f^- >= g^+$\
\
*Следствие:* \
\
$"ПГ"(f^+, [a, b]) < "ПГ"(g^+[a, b]) => &sigma("ПГ"(f^+)) &<= sigma("ПГ"(g^+))\ &sigma("ПГ"(f^-)) &<= sigma("ПГ"(g^-))$\
\ \
*Свойство 3:* $f in C[a, b] =>$\ \
1.$space min f dot (b - a) <= int_a^b f(x) dif x <= max f (b-a) <= max f dot (b - a)$\ \
2.$space abs(int_a^b f) <= int_a^b abs(f)$\  \
3.$space exists c in [a, b]: int_a^b f(x) dif x = f(c) (b-a)$ \ \  
#proof
2.\
$-abs(f(x))<=f(x) <= abs(f(x))$\ \
$-int_a^b abs(f) <= int_a^b f <= int_a^b abs(f)$\ \
3.\
Для $a = b$ утверждение тривиально\ \
Если $a != b$: $min f <= 1/(b-a) int_a^b f <= max f$, далее по теореме о промежуточном значении  $1/(b-a) int_b^a f$ --- значение $f$ в некоторой точке
\ \
#def _интеграл с переменным верхним пределом_ \ $f in C([a, b]), Phi: [a, b] -> RR, Phi(x) = int_a^x f$ --- _интеграл с переменным верхним пределом_\ \

#th (_Барроу_) \ $Phi$ --- интеграл с пер. верх. пределом, дифф на $[a, b]$, $forall x quad Phi'(x)=f(x)$ \ \

#proof \
$int_a^y f - int_a^x f = (int_a^x f + int_x^y f) - int_a^x f$\ \
$y > x: lim_(y->x+0) (Phi(y)-Phi(x))/(y-x)=lim_(y->x+0) 1/(y-x) int_x^y f = lim_(y->x+0) f(c)=f(x)$\ \
$x > y$: аналогично\ \

*Пример:*\ \
$(int_(x^2)^(x^3) e^(-t^2) dif t)'_x = (int_a^x^3 - int_a^x^2)'_x = (Phi(x^3)-Phi(x^2))' = e^(-x^6) dot 3x^2 - e^(-x^4) dot 2x$\ \
$dif/(dif x)(int_(int_(x^2)^(tg x) e^t^2 dif t)^(int_(sin x)^(ln x) sqrt(s^4 + 2 s) dif s) sin n^2 dif n)$ #emoji.face.wink
\ \
#th (_формула Ньютона-Лейбница_)\ \ $f in C([a, b]), F$ --- пер-я $f => int_a^b f(x) dif x = F(b)-F(a)$\ \ \ \
#proof \
$Phi = F+C$\ \
$int_a^b f = Phi(b) - Phi(a) = (F(b)+C) - (F(a)+C)=F(b)-F(a)$

Согласование: $a > b => int_a^b f = -int_b^a f$
#quote("До Ньютона не было законов Ньютона", attribution: "КПК", block: true)
= Верхний предел последовательности

#def _частичный предел последовательности_\ $(x_n) subset RR$. Если $exists a, exists n_k: x_n_k -> a$, то $a$ --- _частичный предел последовательности_ $(x_n)$\ \

*Пример:*
- $x_n = (-1)^n$\
  $n_k: 2, 4, 6, dots => x_n_k->1$\
  $n_k = 1, 3, 5, dots => x_n_k -> -1$
\
#def _верхний предел / нижний предел_ \ $(x_n) subset RR, quad y_n = sup(x_n, x_(n+1), dots), quad z_n = inf(x_n, x_(n+1), dots) => z_n <= x_n <= y_n, quad y_(n+1) >= y_n,quad$$z_(n+1)<=z_n$ \ \
_Верхний предел_ $overline(lim_(n->+infinity)) x_n= limits(op("limsup"))_(n -> +inf) x_n =lim_(n->+infinity) y_n$\ \ _Нижний предел_ $underline(lim_(n->+infinity)) x_n= limits(op("liminf"))_(n->+inf) x_n = lim_(n->+infinity) z_n$
\ \
#th
- $underline(lim) x_n <= overline(lim) x_n$

- $forall n quad x_n <= tilde(x)_n => overline(lim) x_n <= overline(lim) tilde(x)_n, underline(lim) x_n <= underline(lim) tilde(x)_n$
- $lambda >= 0 quad overline(lim) lambda x_n = lambda overline(lim) x_n, underline(lim) lambda x_n = lambda underline(lim) x_n$ ($lambda = 0 => underline(lim) lambda x_n=overline(lim) lambda x_n=0$)
- $overline(lim) (-x_n) = -(underline(lim) x_n), underline(lim) (-x_n) = -(overline(lim) x_n)$
- $overline(lim) (x_n + tilde(x)_n) <= overline(lim) x_n + overline(lim) tilde(x)_n$\
  $underline(lim) (x_n + tilde(x)_n) >= underline(lim) x_n + underline(lim) tilde(x)_n$

\ \
// следующая лекция

#pagebreak()
$(x_n)$\
$y_n = sup(x_n, x_(n+1), dots)$\
$z_n = inf(x_n, x_(n+1), dots)$\
$z_n <= x_n <= y_n$\
$overline(lim) x_n eq.def lim y_n in overline(RR)$\
$underline(lim) x_n = lim z_n$\
$overline(lim) (x_n + tilde(x)_n) <= overline(lim) x_n + overline(lim) tilde(x)_n$\
$sup(x_n + tilde(x)_n, x_n + tilde(x)_(n+1), dots) <= underbrace(sup(x_n, x_(n+1), dots), y_n) + underbrace(sup(tilde(x)_n, tilde(x)_(n+1), dots), tilde(y)_n)$

\ 
// пункт 6
- $t_n -> l in RR => limsup (x_n + t_n) = limsup x_n + l$
#proof
По опр. предела $forall epsilon > 0 quad exists N_0: forall k > N_0 quad l-epsilon < t_k < l + epsilon$\
$x_k + l - epsilon < x_k + t_k < x_k + l + epsilon$\
$~~>_(sup "по" k >= N > N_0) quad y_N + l - epsilon <= limits(sup)_(k >=N) (x_k+t_k) <= y_N + l + epsilon$\
$=> limsup x_n + l - epsilon <= limsup (x_n + t_n) <= limsup x_n + l + epsilon$\
$epsilon -> 0 => limsup (x_n + t_n) = limsup x_n + l$\
\
// пункт 7
- $t_n -> l > 0, l in RR quad limsup (x_n t_n) = limsup x_n dot l$
Без доказательства\ // тудааааа
#th (_Техническое описание верхнего предела_)\
$(x_n)$ --- вещ. последовательность $=>$
- $limsup x_n = +infinity <=> x_n$ не огр сверху

- $limsup x_n = -infinity <=> x_n -> -infinity$
- $limsup x_n = l in RR <=>$
  - $forall epsilon > 0 quad exists N: forall n > N quad x_n < l + epsilon$
  - $forall epsilon > 0 quad exists (n_i): forall i quad x_n_i > l - epsilon$ (т.е. существует бесконечно много n)
#proof
- Очевидно: $=>: y_n -> +infinity quad forall k quad exists y_n > k+1$ т.е. $sup(x_n,x_(n+1),dots)>k+1$ (т.е. $forall k quad exists x_i > k$)
  $arrow.l.double: x_n$ не огр сверху $=> y_n equiv +infinity$
- Очевидно: $x_n <= y_n$\
  $=>: y_n -> -infinity => x_n -> -infinity$\
  $arrow.l.double: forall Epsilon < 0 quad exists N: forall k > N quad x_k < Epsilon => y_(N+1) <= Epsilon$
- $=>:$
  - $y_n -> l, x_n <= y_n => forall epsilon > 0 quad exists N: forall n > N quad x_n <= y_n < l-epsilon$
  - $y_n$ убывает, $y_n -> l => l <= y_n quad forall n$\
    $forall epsilon > 0 quad forall n quad y_n = sup(x_n, x_(n+1), dots)$\
    $exists x_k, k >= n: l - epsilon < x_k$\
    Берём $n=1$, находим $k=k_1$\
    Берём $n>k_1$, находим $k=k_2$\
    Берём $n>k_2$, находим $k=k_3$\
    И т.д.
- $arrow.l.double:$\
  - $space forall epsilon > 0 quad exists N: forall n > N quad x_n < l + epsilon => y_n <= l + epsilon, x_(n+1) < l + epsilon, x_(n+2) < l+epsilon, dots$\
    $=> forall epsilon > 0 quad exists N: forall n > N quad y_n <= l + epsilon$\
  - $forall epsilon > 0 quad forall n quad y_n >= l - epsilon$\
    т.к. $y_n=sup(x_n, x_(n+1), dots), exists$ б.м. $x_i > l-epsilon$\
    $=> forall n quad y_n >= l$
  $=> y_n -> l$
#th\
$(x_n)$ --- вещ. последовательность $=> exists lim x_n in overline(RR) <=> limsup x_n = liminf x_n$ и если оба утв. верны, все 3 предела совпадают
#proof
- $=>: lim x_n = plus.minus infinity => $ очев.: $limsup x_n = +infinity$ ($x_n$ не огр сверху $=> limsup x_n = +infinity$)\
  $liminf x_n = +infinity$ по тех. описанию, п.2\ \
  Если $lim x_n = -infinity$ #emoji.face.smile.slight Аналогично\ \
  Пусть $lim x_n = l in RR$, выполняется тех. описание $=> limsup x_n=l$\
  Аналогично $liminf x_n = l$
- $arrow.l.double: z_n <= x_n <= y_n, z_n -> l, y_n -> l => x_n -> l$
#th (_о характеризации верхнего предела как частичного_)\
$(x_n)$ --- вещ. последовательность $=>$
- $forall l in overline(RR)$ --- частичный предел $x_n: liminf x_n <= l <= limsup x_n$
- $exists n_k: x_n_k ->_(k->infinity) limsup x_n, exists m_j: x_m_j ->_(j->+infinity) liminf x_n$
#proof
- $n_k: x_n_k -> l quad z_n_k <= x_n_k <= y_n_k$\
  $z_n_k -> liminf x_n, x_n_k -> l, y_n_k -> limsup x_n => liminf x_n <= l <= limsup x_n$
- Про верхний: $limsup x_n = plus.minus infinity$ очев\
  $limsup x_n = l in RR => exists n_k: l-1/k < x_n_k < l+1/k$ (из тех. описания)\
  $l-1/k -> l, l+1/k -> l => x_n_k -> l$
*Пример:*\
$x_n = sin n$\
$limsup sin n = 1$\
$forall k quad sup(sin k, sin(k+1), dots)=1$\
Будем блуждать по окружности с шагом $n_i$.\
$n_0 = 1$\
$n_1 = 6$\
$n_1, 2n_1, 3n_1, dots$\
$n_2 = n_1 k$ или $n_1 (k+1)$ (соответственно более короткой половинке дуги, которую делит 0)\
$n_2, 2n_2, dots$\
$n_3 = n_2 l$ или $n_2 (l+1)$ (аналогично)\
и т.д.\
Длина шага: $1, <1/2, <1/4, <1/8, dots$\
$1/2^k < epsilon$\
Существует б.много $sin x_k > 1-epsilon, sin x_k <= 1 forall k => limsup sin n = 1$\

// тут должна быть 4 лекция
#pagebreak()
// скип

//тут короче лекция скипнута, надо дотехать

#pagebreak()
// ты сегодня на удалёнке? ага

$f: [a, b] -> RR$ --- кусочно непрерывная \
$x_0 = a < x_1 , x_2 < dots < x_(n - 1) < b = x_n$\
--- $forall k quad f$ --- непрерывная на $(x_(k - 1), x_k)$ \ 
$exists $ конечный $lim_(x->x_k- 0) f, space lim_(x->x_(k-1)+0) f$\
Тогда можно считать, что  $ forall k quad f in C([x_(k-1), x_k])$, $quad int_a^b f = sum_(k=1)^n int_(x_(k-1))^(x_k) f$\
#def почти первообразная \ $F$ --- _почти первообразная_ $f(x)$, если \ $F in C[a, b]$, дифф. всюду кроме кон. числа точек, $F'(x) = f(x) space forall x$, где $F$ дифф.
\ \
#th\
$f$ --- кус. непр., $F$ --- почти первообр.\
Тогда:  $int_a^b = F(b) - F(a)$\ #v(0.1cm)
$int_a^b f = sum_(k=1)^n space int_(x_(k-1))^(x_k) = sum_(k=1)^n F(x_k) - F(x_(k - 1)) = F(x_n) - F(x_0) = F(b) - F(a)$\ #v(0.1cm)
На $(x_(k-1), x_k) F$ --- первообразная $f$\ #v(0.1cm) $quad space space[x_(k-1), x_k]  tilde(F): F = tilde(F)$ на $(x_k, x_(k-1))$

#image("1.png", width: 30%)
\ \
*Пример:* неравенство Чебышева\
$I_f dot I_g <= I_(f g) quad$ ($f, g$ --- возр), $space I_f = 1/(b-a) int_a^b f$
\ \
*Утверждение:*\
$a_1 <= a_2 <= dots <= a_n$, $ space b_1 <= b_2 <= dots <= b_n$\ #v(0.2cm)
Тогда $(1/n sum_(k=1)^n a_k) (1/n sum_(k=1)^n b_k) <= 1/n (sum_(k=1)^n a_k b_k)$\ #v(0.2cm)
#proof
#image("2.png", width: 30%)
$f(x) = a_(ceil(x)), quad x in (0, n]$\
На $(k-1, k) quad F(x) = x dot a_k, space x in [k-1, space k]$\
$ F(x) = cases(delim: "[", a_1 x && x in [0, 1], a_2 x + (a_1-a_2) &quad& x in [1, 2], a_3 x + (a_1+a_2-2a_3) && x in [2, 3], dots dots) $

= Правило Лопиталя
_by_ Иоганн Бернулли
== Лемма об ускоренной сходимости
$f, g: D subset RR -> RR, space a$ --- предельная точка $D, space a in overline(RR)$\
Пусть $exists dot(U) (a) quad f != 0, g != 0$\
$lim_(x->a) f(x) = 0, lim_(x->a) g(x) = 0$\
Тогда $forall (x_k), space x_k -> a, space x_k in D, space  x_k != a quad exists (y_k), space  y_k -> a, space y_k in D, space y_k != a: lim f(y_k)/g(y_k) = 0, space lim g(y_k)/g(x_k) = 0$
#proof
$y_k$ будем искать в посл. $(x_n)$ так, чтобы $abs(f(y_k)/g(x_k)) < 1/k, space abs(g(y_k)/g(x_k)) < 1/k, quad abs(f(y_k)) < 1/k abs(g(x_k)), quad abs(f(x_k)) < 1/k abs(g(x_k)) $\
== Лемма 2
Аналогичное верно для случая\
$lim_(x->a) f = +infinity, space lim_(x->a) g = +infinity$\ #v(0.2cm)
$forall (x_k), dots quad exists (y_k), dots: lim f(y_k)/g(x_k) = 0, dots = 0$
== Правило Лопиталя
$f, g: (a, b) -> RR, space a in overline(RR)$\
дифф.\
$g' != 0$ на $(a, b)$\ #v(0.2cm)
$lim_(x->a + 0)f/g = [0/0, space infinity/infinity]$\ #v(0.2cm)
Пусть $lim_(x->a+0) (f'(x))/(g'(x)) = A in overline(RR)$\ #v(0.2cm)
Тогда $exists lim_(x->a+0) f/g = A$ // дошик среди теорем
\ \
#proof
$g' != 0 => g' $ --- сохраняет знак (т. Дарбу) $=> g$ --- строго монотонно $=>$ в окр. точки $a space g != 0$\
По Гейне $x_k-> a, space  x_k != a, space x_k in (a, b), space $ строим последовательность $y_k$ из леммы\ #v(0.2cm)
$(f(x_k) - f(y_k))/(g(x_k) - g(y_k)) = (f'(xi_k))/(g'(xi_k)), space f(x_k) - f(y_k) = (f'(xi_k))/(g'(xi_k)) (g(x_k) - g(y_k))$\ #v(0.2cm)
$f(x_k)/g(x_k) = limits(f(y_k)/g(x_k))_(arrow.b\ 0)+limits((f'(xi_k))/(g'(x_k)))_(arrow.b\ A) dot (1-limits(g(y_k)/g(x_k))_(arrow.b\ 0))$\ \
*Пример:*\ #v(0.2cm)
$lim_(x-> +infinity) x/(sqrt(x^2 + 1)) = lim_(x->+infinity) 1/(x/(sqrt(x^2 + 1))) = lim_(x -> + infinity) sqrt(x^2 + 1)/x=$#smile\ #v(0.2cm)
$0 =lim_(x->0) (x^2 sin 1/x)/(sin x) = lim_(x->0) (2limits(x)^(0\ arrow.t) sin 1/x - cos 1/x)/limits(cos x)_(arrow.b\ 1)=$#frown\
$lim_(x->0+) ln(x)/x = lim_(x->+0) (1/x)/1 = lim_(x->+0) 1/x = +infinity$\ \ \ \ \ \ \ \ \ \
*Пример:*\ #v(0.2cm)
$int_0^(+infinity) = sqrt(pi)/2$ --- интеграл Эйлера-Пуассона\ #v(0.2cm)
$int_0^R e^(-x^2) dif x ->_(R->+infinity) sqrt(pi)/2$\
$sqrt(pi)/2 - int_0^R e^(-x^2) ->_(R->+infinity) 0$\ #v(0.2cm)
$1 = lim_(R->+infinity) (sqrt(pi)/2 - int_0^R e^(-x^2) dif x)/g(R) = [0/0] =lim_(R->+infinity) (-e^(-R^2))/(g'(R))=1$\ \
I попытка:\
$g(R)=e^(-R^2)$\
$g' = -2R e^(-R^2)$\
$(e^(-R^2))/(-2R e^(-R^2)) -> 0$\
II попытка:\
$g(R) = (e^(-R^2))/(2R)$\
$(e^(-R^2))/(e^(-R^2) - (e^(-R^2))/limits(2R)_(=o(e^(-R^2)))) ->_(R->+infinity) 1$\
$int_0^R e^(-x^2) dif x = sqrt(pi)/2 - (e^(-R^2))/(2R) + o((e^(-R^2))/R)$

= Приложение определённого интеграла
_Общая схема_ $ space dp(a, space b)$\
$"Segm" (dp(a, space b)) = {[p, q]: [p, q] subset dp(a, b)}$\
== Аддитивная функция промежутка
#align(center)[#image("3.png", width: 20%)_представление Segm$[p, q] in $ Segm$(a, b)$, если $(p, q)$ лежит в заштрихованном треугольнике_] // 
\
$Phi: "Segm" dp(a, b) -> RR$\
$forall [p, q] in "Segm" dp(a, b) quad forall c in [p, q] quad Phi([p, q]) = Phi([p,c]) + Phi([c, q])$\
$[p, q] |-> int_p^q f$

== Плотность аддитивной функции промежутка
$Phi: "Segm" dp(a, b) -> RR, space f: dp(a, b) -> RR$\
$f$ --- плотность $Phi$, если $forall Delta in "Segm": limits(min)_Delta f dot l_Delta <= Phi(Delta) <= limits(max)_Delta f dot l_Delta$\
\ \
*Теорема:* (о вычислении а. ф. п. по плотности)\
$f: dp(a, b) -> RR, $ --- непрерывна\ $Phi: "Segm" dp(a, b) -> RR$ --- а.ф.п\
$f$ --- плотность $Phi$\
Тогда:\
$forall [p, space q] in "Segm" quad Phi([p, q]) = int_p^q f(x)d x$

#proof
Не умаляя общности рассмотрим $[a, b]$\ #v(0.2cm)
$F(x) = cases(delim: "[", 0\, &quad& x=a, Phi([a, x])\, &&x in (a, b])$\ #v(0.2cm)
Проверим $F$ --- первообразная $f$\ #v(0.2cm)
$(F(x + h) - F(x)) / h = (Phi[a, x+h] - Phi[a, x])/h = Phi([x, x+h])/h = f(x + Theta h), space 0 <= Theta <= 1$\ #v(0.2cm)
$F'_+ = lim_(h->+0) dots = f(x)$\ #v(0.2cm)
Аналогично $F'_- = f(x)$\ #v(0.2cm)
$int_p^q f = F(q) - F(p) = Phi([p, q])$
\ \
*Пример 1:* площадь подграфика\ #v(0.2cm)
$f: dp(a, b) -> R$, непр.\ #v(0.2cm)
$f$ --- плотность, из монотонности площади\
#image("4.png", width: 25%)
$min f (q - p) <= sigma("ПГ"(f, [p, q])) <= max f (q-p)$\ #v(0.2cm)
$Phi: "Segm" dp(a, b) -> RR$\ #v(0.2cm)
$Phi([p, q]) = sigma("ПГ"(f, [p, q])) = int_p^q f$\ \
*Пример:*\ #v(0.2cm)
$x^2/a^2 + y^2/b^2 = 1$\
#align(center)[#image("5.png", width: 25%) _График эллипса_]
#align(center)[#image("6.png", width: 25%) _Геометрический способ поиска площади подграфика_] // из-за свойств симметрии синусоиды площадь подграфика равна половине площади прямоугольника

$x=a cos t, t in [pi, 0]$\ #v(0.2cm)
$y=b sin t$\ #v(0.2cm)
$sigma_"элл" = int_(-a)^a y^+ (x) dif x = -int_pi^0 b sin t dot a sin t dif t=a b int_0^pi sin^2 t dif t = a b pi/2$\ \
*Пример 2:* площадь криволинейного сектора
$dp(a, b)$\
$Phi: [p, q] |-> sigma "Сектор" ([p, q], r(phi))$\
Проверим, что $1/2 r^2 (phi)$ --- плотность а.ф.п. $Phi$\
$1/2 limits(min)_([p, q]) r^2 (phi) (q-p) <= Phi [p, q] <= 1/2 limits(max)_([p, q]) r^2 (phi) dot (q - p)$\
Кр. сектор $([p, q], min r) subset$ Сектор $([p, q], r(phi)) subset$ Кр. сект. $([p, q], max r)$\
Т.е. $Phi([p, q]) = 1/2 int_p^q r^2 (phi) dif phi$\
\
Посчитаем площадь круга\ #v(0.2cm)
$sigma "Круга" = 1/2 int_0^(2pi) R^2 d phi = pi R ^2$ #smile\
$phi=arctan g(t)/x(t)$\
$r=sqrt(x^2+y^2)$\
$S'=1/2 int_p^q r^2 (phi) d phi =_#smile 1/2 int_(t_p)^(t_q) = (x^2+y^2) dot 1/(1+(y^2(t))/(x^2(t))) dot (y'x - x'y)/(x^2) dif t=1/2 int_(t_p)^(t_q) y'(t)x(t)-x'(t)y(t)dif t$\ \
$x=R cos t, t in [0, pi/2]$\
$y=R sin t$\
$S = R^2/2 int_0^(pi/2) cos^2 t + sin^2 t dif t = (pi R^2)/4$
\
\
*Пример:* Изометрическое пространство\
$G subset RR^2 space space G$ --- замкнутая выпуклая фигура. Диаметр $G = sup(rho(A, space B), space A, space B in G) =d<= 1$\
Тогда $sigma(G) <= pi (d/2)^2 quad$ (равенство для круга $r = 1/2$)
\ \
#proof
$f(x)$ --- вып., $x_0$ где $exists f'(x_0) => exists$ касательная\
$Phi$ замк., вып. $=> r(phi)$ непр.
$sigma = 1/2 int_(-pi/2)^(pi/2) r^2 (phi) dif phi=1/2 int_0^(pi/2) + int_(-pi/2)^0 = 1/2 int_0^(pi/2) r^2 (phi) dif phi + 1/2 int_0^(pi/2) r^2 (phi_"нов"-pi/2) dif phi_"нов"=$\
$=1/2 int_0^(pi/2) r^2 (phi) + r^2 (phi - pi/2) dif phi=1/2 int_0^(pi/2) \"A B\"^2 dif phi<=1/2 int_0^(pi/2) d^2 dif phi = (pi d^2)/4$\ \
#def циклоида --- траектория точки на окружности, катящейся по прямой\
// см лекцию для объяснения этого треша
$S_"черн" + S_"син" = S_"прям" + S_"лепестка"$\
$S = 2 pi r^2 + pi r^2$\
$S=3 pi r^2$\ \
$ cases(x(phi) = r phi - r sin phi, y(phi) = r - r cos phi), phi in [0, 2pi] $\
$S = int_0^(2pi r) y(x) dif x = int_0^(2pi) (r-r cos phi) (r-r cos phi) dif phi=r^2 int_0^(2pi) 1-2 cos phi + cos^2 phi dif phi = 2 pi r^2 + 0+pi r^2$
// вместо изюминки вы прожевали доширак, я не знаю. чушь какая-то
