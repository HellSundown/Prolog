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
    plist : (main::company*) nondeterm.
    v_otdele : (string Otdel) -> main::company* VOtdele nondeterm.

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
        succeed.

end implement main

goal
    console::run(main::run).
