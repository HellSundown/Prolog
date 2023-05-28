% Copyright

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

class facts
    s : (real Sum) single.
    a : (real Age) single.

clauses
    s(0).
    a(0).

class predicates
    sotrudVotdele : (string Name) nondeterm.
    sotrud : (integer Id_S) nondeterm.
    otdelsalary : (string Name) nondeterm.
    sotage : (integer Id_S) nondeterm.
    ruk : () nondeterm.
    othier : (string Name) nondeterm.
    otpodch : () nondeterm.

clauses
    %Вывод сотрудника по айдишнику
    sotrud(X) :-
        sotr(X, Y, _, _, _),
        write("Сотрудник: ", Y),
        fail.
    sotrud(X) :-
        sotr(X, _, _, _, _),
        write("\n"),
        nl.

    %Вывод сотрудников конкретного отдела
    sotrudVotdele(X) :-
        otdel(O, X),
        dolg(D, _, _, O),
        zanimaet(T, D, _),
        sotr(T, N, _, _, _),
        write("Сотрудник отдела ", X, ": ", N),
        nl,
        fail.
    sotrudVotdele(X) :-
        otdel(_, X),
        write("\n"),
        nl.

    %Вывод суммы всех зарплат в отделе
    otdelsalary(N) :-
        otdel(I, N),
        zanimaet(L, D, _),
        dolg(D, _, _, I),
        salary(L, Z),
        s(Sum),
        assert(s(Sum + Z)),
        fail.
    otdelsalary(N) :-
        otdel(_, N),
        s(Sum),
        write("Общая зарплата в Marketing: ", Sum, "\n"),
        write("\n"),
        nl.

    %Вывод возраста конкретного сотрудника на момент приёма
    sotage(I) :-
        sotr(I, _, _, date(Y1, _, _), date(Y2, _, _)),
        a(Age),
        assert(a(Age + Y2 - Y1)).
    sotage(I) :-
        sotr(I, N, _, _, _),
        a(Age),
        write(N, " имел(а): ", Age, " лет", "\n"),
        write("\n"),
        nl.

    %Вывод всех начальников
    ruk() :-
        dolg(D, "Nachalnik otdela", _, ОI),
        otdel(ОI, NM),
        write("Начальник отдела ", NM, ": "),
        sotr(I, N, _, _, _),
        zanimaet(I, D, _),
        write(N),
        nl,
        fail.
    ruk() :-
        otdel(_, _),
        write("\n").
        %Вывод всех замов
    ruk() :-
        dolg(D, "Zamestitel nachal'nika", _, ОI),
        otdel(ОI, NM),
        write("Заместитель отдела ", NM, ": "),
        sotr(I, N, _, _, _),
        zanimaet(I, D, _),
        write(N),
        nl,
        fail.
    ruk() :-
        otdel(_, _),
        write("\n").
        %Вывод всех рядовых
    ruk() :-
        dolg(D, "Sotrudnik otdela", _, ОI),
        otdel(ОI, NM),
        write("Рядовые отдела ", NM, ": "),
        sotr(I, N, _, _, _),
        zanimaet(I, D, _),
        write(N),
        nl,
        fail.
    ruk() :-
        otdel(_, _),
        write("\n").

    %Вывод сотрудников конкретного отдела по иерархии
    othier(N) :-
        otdel(IO, N),
        sotr(I, M, _, _, _),
        zanimaet(I, D, _),
        dolg(D, "Nachalnik otdela", _, IO),
        write("Начальник: ", M),
        nl,
        fail.
    othier(N) :-
        otdel(IO, N),
        sotr(I, M, _, _, _),
        zanimaet(I, D, _),
        dolg(D, "Zamestitel nachal'nika", _, IO),
        write("Заместитель: ", M),
        nl,
        fail.
    othier(N) :-
        otdel(IO, N),
        sotr(I, M, _, _, _),
        zanimaet(I, D, _),
        dolg(D, "Sotrudnik otdela", _, IO),
        write("Рядовой: ", M),
        nl,
        fail.
    othier(_) :-
        otdel(_, _),
        write("\n").

    otpodch() :-
        podch(OI, OIP),
        otdel(OI, O),
        otdel(OIP, O2),
        write("Отдел ", O, " подчиняется отделу ", O2),
        nl,
        fail.
    otpodch() :-
        otdel(_, _),
        write("\n").
%----------------------------------------------------------------------
    run() :-
        console::init(),
        reconsult("../rabot.txt", company),
        write("---Вывод сотрудника №9 по айдишнику---\n"),
        sotrud(9),
        fail.

    run() :-
        console::init(),
        reconsult("../rabot.txt", company),
        write("---Вывод сотрудников отдела Sell---\n"),
        sotrudVotdele("Sell"),
        fail.

    run() :-
        console::init(),
        reconsult("../rabot.txt", company),
        write("---Вывод суммы всех зарплат в отделе Marketing---\n"),
        otdelsalary("Marketing"),
        fail.

    run() :-
        console::init(),
        reconsult("../rabot.txt", company),
        write("---Вывод возраста сотрудника №9 на момент приёма---\n"),
        sotage(9),
        fail.

    run() :-
        console::init(),
        reconsult("../rabot.txt", company),
        write("---Вывод всех работников по иерархии---\n"),
        ruk(),
        fail.

    run() :-
        console::init(),
        reconsult("../rabot.txt", company),
        write("---Вывод сотрудников отдела Develop по иерархии---\n"),
        othier("Develop"),
        fail.

    run() :-
        console::init(),
        reconsult("../rabot.txt", company),
        write("---Вывод подчинения отделов---\n"),
        otpodch(),
        fail.

    run() :-
        succeed.

end implement main

goal
    console::run(main::run).
