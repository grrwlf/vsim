entity test is
end entity test;

architecture test of test is

    constant c : integer := 0;

    type arr01 is array (0 to 1) of integer;

    procedure p1(constant i:integer) is
    begin
    end;

    procedure p2(constant i:integer) is
    begin
        return;
    end;

    function f1(a1 : arr01) return integer is
	begin
        return a1(c);
    end function;

begin

    main: process
        variable i : arr01 := (others => 33);
        variable x : integer := 10;
    begin
        p1(c);
        p2(c);
        x := f1( i );
        report integer'image(x);
        assert false report "end of simulation" severity failure;
    end process;

end architecture test;


