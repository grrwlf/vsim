package com.prosoft.vhdl.ir;

/**
 * 
 * ���, ������� ��� �� ���� �������� �����, ����� ��� ���������, ������� ���������� ���
 *
 */

public class IRTypeType extends IRType {

	public IRTypeType(IRPackage pack) {
		super(pack, "TYPE_TYPE");
	}

	@Override
	public IRType dup() {
		return new IRTypeType(pack);
	}

	@Override
	public boolean isAssignableFrom(IRType type) {
		return false;
	}

	@Override
	public boolean isEqualTo(IRType type) {
		return type instanceof IRTypeType;
	}

	@Override
	public boolean isType() {
		return true;
	}

}
