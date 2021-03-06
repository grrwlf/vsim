entity ENT00001_Test_Bench is
end entity ENT00001_Test_Bench;

architecture arch of ENT00001_Test_Bench is
	constant CYCLES : integer := 1000;
	signal clk : integer := 0;
	signal n   : integer := 0;
begin
    main: process(clk)
	begin
		n <= 1 after 10 us;
    end process;

	terminator : process(clk)
	begin
		if clk >= CYCLES then
			assert false report "end of simulation" severity failure;
		-- else
		-- 	report "tick";
		end if;
	end process;

	clk <= (clk+1) after 1 us;
end;
