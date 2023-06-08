implement main
    open core, file, stdio

domains
    gender = m; f.
    year = integer.
    month = integer.
    day = integer.
    date = date(year, month, day).

class facts - company
    sotr : (integer Id_S, string FullName, gender Gender, date BirthDate, date HireDate).
    otdel : (integer Id_O, string Name).
    dolg : (integer Id_D, string Title, string Description, integer DepartmentId).
    podch : (integer Oname1, integer OName2).
    zanimaet : (integer EmployeeId, integer PositionId, date StartDate).
    salary : (integer Id_S, integer Money).
%----------------^^^осталось без изменений^^^----------------

class predicates
    length : (A*) -> integer N.
    summ : (real* List) -> real Sum.
    laverage : (real* List) -> real Average determ.
    max : (real* List, real Max [out]) nondeterm.
    min : (real* List, real Min [out]) nondeterm.

clauses
    length([]) = 0.
    length([_ | T]) = length(T) + 1.
    summ([]) = 0.
    summ([B | T]) = summ(T) + B.

    laverage(L) = summ(L) / length(L) :-
        length(L) > 0.
    max([Max], Max).

    max([B1, B2 | T], Max) :-
        B1 >= B2,
        max([B1 | T], Max).

    max([B1, B2 | T], Max) :-
        B1 <= B2,
        max([B2 | T], Max).
    min([Min], Min).

    min([B1, B2 | T], Min) :-
        B1 <= B2,
        min([B1 | T], Min).

    min([B1, B2 | T], Min) :-
        B1 >= B2,
        min([B2 | T], Min).

class predicates
    plist : (main::company*) nondeterm.
    v_otdele : (string Otdel) -> main::company* VOtdele nondeterm.
    sumsalary : () -> real Sum.
    maxsalary : () -> real Max determ.
    minsalary : () -> real Min determ.

clauses
    v_otdele(Otdel) = VOtdele :-
        otdel(O, Otdel),
        dolg(D, _, _, O),
        zanimaet(T, D, _),
        %генератор списка (List Comprehension)
        VOtdele = [ sotr(T, N, S, D1, D2) || sotr(T, N, S, D1, D2) ].
        %вывод данных поэлементно
    plist([X | Y]) :-
        write(X),
        nl,
        plist(Y).

    sumsalary() = Sum :-
        Sum = summ([ Budget || salary(_, Budget) ]).

    maxsalary() = Res :-
        max([ Budget || salary(_, Budget) ], Max),
        Res = Max,
        !.
    minsalary() = Res :-
        min([ Budget || salary(_, Budget) ], Min),
        Res = Min,
        !.
%----------------------------------------------------------------------
    run() :-
        file::consult("../rabot.txt", company),
        fail.
    run() :-
        write("\n---Вывод сотрудников отдела Sell---\n"),
        PList = v_otdele("Sell"),
        plist(PList),
        nl,
        fail.
    run() :-
        write("\nСумма для всей компании:", sumsalary()),
        nl,
        write("Максимальная зарплата сотрудника:", maxsalary()),
        nl,
        write("Минимальная зарплата сотрудника:", minsalary()),
        nl,
        fail.
    run() :-
        succeed.

end implement main

goal
    console::run(main::run).
