package com.prosoft.vhdl.ir;

public interface IRangedElement {

	/*
	public IROper getRangeLow();
	public IROper getRangeHigh();
	IROper isDownTo();

	public void setRangeLow(IROper rangeLow);
	public void setRangeHigh(IROper rangeHigh);
	public void setDownTo( IROper downTo );
	
	// ��� �������, ����� ��� ���� ��������� ������� ����-����� ���� ��������� leftRight � true
	// ��� ��� "����" ������������� !isDownTo, "�����" isDownTo
	public void setLeftRight(boolean leftRight);
	public boolean isLeftRight();
	public IROper isRight();
	
	public boolean isConst();
	
    */
	IROperRange getRange();
	IRangedElement dup();
    // ��� ��������� ��� unconstrained ��������
    IRType getRangeType();

}
