package com.prosoft.vhdl.ir;

public enum IROperKind {
	
	ERROR,
	
	CNST_ASGN, // �������������� ������������� ���������
	// statements
	VAR_ASGN,
	SIG_ASGN,
	IF,
	CASE,
	RETURN,
	FOR,
	WHILE,
	ETERNAL_LOOP,
	EXIT,
	STATS,
	EMPTY_STATEMENT,
	PROC_CALL,
	SELECT_ASGN,
	WAIT,
	REPORT,
	ASSERT,
	
	GEN_IF, // �������� generate
	GEN_FOR,
	
//	OBJECT, // ��������� ��������������, ��� ��� ���������� ������������ ������� (������� ��� ����������)
	
	QUALIFY,
	
	RANGE,
	
	COND,
	
	NAME, // ������-��������, ������� �������� ������ ���
	
	ASSOC, // association, ����� ����� - ������������, �������� ������������� ������ �����
	
	CHOICES,
	
	AGGREG,
	
	INDEX,
	
	ATTRIB,
	
	ARRAY_BOUND,
	
	OTHERS,
	ALL,
	OPEN,
	NULL,
	
	COMMA,
	
	CONST,
	
	CONST_READ, // ������ ��������� � ���-����
	
	FCALL, // function call
	
	OPERATOR_SYMBOL,
	
	TYPE_CAST,
	
	AFTER,

	// logical 
	AND,
	OR,
	NAND,
	NOR,
	XOR,
	XNOR,


	// shift
	SLL,
	SRL,
	SLA,
	SRA,
	ROL,
	ROR,

	// relation
	EQ,
	NEQ,
	LO,
	LE,
	GT,
	GE,

	// adding
	ADD,
	SUB,
	CONCAT,

	// multiplying
	MUL,
	DIV,
	MOD,
	REM,
	
	POW,
	
	NEG,
	ABS,
	NOT,
	
	SGNL,
	VAR,
	ALIAS,
	
	DOT,
	FIELD,
	QUOTE,
}
