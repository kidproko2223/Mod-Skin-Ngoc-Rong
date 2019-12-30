#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

#include "NomadMemory.au3"

#Region ### START Koda GUI section ### Form=
$fChangeSkin = GUICreate("ModSkin", 219, 105, 527, 124)
$cbSkin = GUICtrlCreateCombo("xen bo hung 2", 8, 8, 201, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "xen bo hung 3|pic|poc|king kong|dr kore")
$btnChangeSkin = GUICtrlCreateButton("Change Skin", 8, 40, 203, 57)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Func ChangeSkin($skinName)
	; nếu các bạn muốn hiểu các tham số thì đọc help của nó là được
	$iv_Pid = WinGetProcess("DragonBoy") ; get process ID
	$handle = _MemoryOpen($iv_Pid)
	If @error = 0 Then ; neu khong co loi
		Local $dau
		Local $than
		Local $chan
		If $skinName = "xen bo hung 2" Then
			$dau = 231
			$than = 232
			$chan = 230
		ELseIf $skinName = "xen bo hung 3" Then
			$dau = 234
			$than = 235
			$chan = 233
		ELseIf $skinName = "pic" Then
			$dau = 237
			$than = 238
			$chan = 239
		ELseIf $skinName = "poc" Then
			$dau = 240
			$than = 241
			$chan = 242
		ELseIf $skinName = "king kong" Then
			$dau = 243
			$than = 244
			$chan = 245
		ELseIf $skinName = "dr kore" Then
			$dau = 255
			$than = 256
			$chan = 257
		EndIf
		; $iv_Address -> base address
		; $ah_Handle -> lay tu ham memoryopen
		; $av_Offset -> mang cac offset, voi offset[0] = 0
		; $v_Data -> moi dung data muon ghi
		Local $offsetsDau[4] = [0x0, 0x80, 0xFD0, 0x350]
		Local $offsetThan[4] = [0x0, 0x80, 0xFD0, 0x358]
		Local $offsetsChan[4] = [0x0, 0x80, 0xFD0, 0x354]
		; o day ban de y mono.dll + 0x...... -> vay base adress o day la gi?
		; don gian chi can xem mono.dll co base la bao nhieu roi cong voi phan dang sau la dc
		; base cua mono.dll la 10000000
		; cong voi phan dang sau se co dc base address
		$baseAddress = 0x101F36AC
		; ghi phan dau
		_MemoryPointerWrite($baseAddress, $handle, $offsetsDau, $dau)
		; ghi phan than
		_MemoryPointerWrite($baseAddress, $handle, $offsetThan, $than)
		; ghi phan chan
		_MemoryPointerWrite($baseAddress, $handle, $offsetsChan, $chan)
		; đóng memory
		_MemoryClose($handle)
	EndIf
EndFunc


While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $btnChangeSkin
			ChangeSkin(GUICtrlRead($cbSkin))
	EndSwitch
WEnd
