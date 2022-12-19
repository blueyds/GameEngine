import SwiftUI

extension Keyboard{
    public static func SetKeyPressed(_ keyCode: UIKeyboardHIDUsage, isOn: Bool){
        SetKeyPressed(getKeyCode(keyCode), isOn: isOn)
    }
    public static func ToggleKeyPressed(_ keyCode: UIKeyboardHIDUsage){
        ToggleKeyPressed(getKeyCode(keyCode))
    }
//    public static func IsKeyPressed(_ keyCode: UIKeyboardHIDUsage)-> Bool{
//        IsKeyPressed(getKeyCode(keyCode))
//    }
    private static func getKeyCode(_ keyCode: UIKeyboardHIDUsage)-> UInt16{
        KeyboardDictionary[keyCode] ?? 0xFF
    }
}
let KeyboardDictionary: [UIKeyboardHIDUsage: UInt16] = [
    UIKeyboardHIDUsage.keyboardA:Keyboard.KeyCodes.a.rawValue,
    UIKeyboardHIDUsage.keyboardB:Keyboard.KeyCodes.b.rawValue,
    UIKeyboardHIDUsage.keyboardC:Keyboard.KeyCodes.c.rawValue,
    UIKeyboardHIDUsage.keyboardD:Keyboard.KeyCodes.d.rawValue,
    UIKeyboardHIDUsage.keyboardE:Keyboard.KeyCodes.e.rawValue,
    UIKeyboardHIDUsage.keyboardF:Keyboard.KeyCodes.f.rawValue,
    UIKeyboardHIDUsage.keyboardG:Keyboard.KeyCodes.g.rawValue,
    UIKeyboardHIDUsage.keyboardH:Keyboard.KeyCodes.h.rawValue,
    UIKeyboardHIDUsage.keyboardI:Keyboard.KeyCodes.i.rawValue,
    UIKeyboardHIDUsage.keyboardJ:Keyboard.KeyCodes.j.rawValue,
    UIKeyboardHIDUsage.keyboardK:Keyboard.KeyCodes.k.rawValue,
    UIKeyboardHIDUsage.keyboardL:Keyboard.KeyCodes.l.rawValue,
    UIKeyboardHIDUsage.keyboardM:Keyboard.KeyCodes.m.rawValue,
    UIKeyboardHIDUsage.keyboardN:Keyboard.KeyCodes.n.rawValue,
    UIKeyboardHIDUsage.keyboardO:Keyboard.KeyCodes.o.rawValue,
    UIKeyboardHIDUsage.keyboardP:Keyboard.KeyCodes.p.rawValue,
    UIKeyboardHIDUsage.keyboardQ:Keyboard.KeyCodes.q.rawValue,
    UIKeyboardHIDUsage.keyboardR:Keyboard.KeyCodes.r.rawValue,
    UIKeyboardHIDUsage.keyboardS:Keyboard.KeyCodes.s.rawValue,
    UIKeyboardHIDUsage.keyboardT:Keyboard.KeyCodes.t.rawValue,
    UIKeyboardHIDUsage.keyboardU:Keyboard.KeyCodes.u.rawValue,
    UIKeyboardHIDUsage.keyboardV:Keyboard.KeyCodes.v.rawValue,
    UIKeyboardHIDUsage.keyboardW:Keyboard.KeyCodes.w.rawValue,
    UIKeyboardHIDUsage.keyboardX:Keyboard.KeyCodes.x.rawValue,
    UIKeyboardHIDUsage.keyboardY:Keyboard.KeyCodes.y.rawValue,
    UIKeyboardHIDUsage.keyboardZ:Keyboard.KeyCodes.z.rawValue,
    UIKeyboardHIDUsage.keyboard0:Keyboard.KeyCodes.zero.rawValue,
    UIKeyboardHIDUsage.keyboard1:Keyboard.KeyCodes.one.rawValue,
    UIKeyboardHIDUsage.keyboard2:Keyboard.KeyCodes.two.rawValue,
    UIKeyboardHIDUsage.keyboard3:Keyboard.KeyCodes.three.rawValue,
    UIKeyboardHIDUsage.keyboard4:Keyboard.KeyCodes.four.rawValue,
    UIKeyboardHIDUsage.keyboard5:Keyboard.KeyCodes.five.rawValue,
    UIKeyboardHIDUsage.keyboard6:Keyboard.KeyCodes.six.rawValue,
    UIKeyboardHIDUsage.keyboard7:Keyboard.KeyCodes.seven.rawValue,
    UIKeyboardHIDUsage.keyboard8:Keyboard.KeyCodes.eight.rawValue,
    UIKeyboardHIDUsage.keyboard9:Keyboard.KeyCodes.nine.rawValue,
    UIKeyboardHIDUsage.keypad0:Keyboard.KeyCodes.keypad0.rawValue,
    UIKeyboardHIDUsage.keypad1:Keyboard.KeyCodes.keypad1.rawValue,
    UIKeyboardHIDUsage.keypad2:Keyboard.KeyCodes.keypad2.rawValue,
    UIKeyboardHIDUsage.keypad3:Keyboard.KeyCodes.keypad3.rawValue,
    UIKeyboardHIDUsage.keypad4:Keyboard.KeyCodes.keypad4.rawValue,
    UIKeyboardHIDUsage.keypad5:Keyboard.KeyCodes.keypad5.rawValue,
    UIKeyboardHIDUsage.keypad6:Keyboard.KeyCodes.keypad6.rawValue,
    UIKeyboardHIDUsage.keypad7:Keyboard.KeyCodes.keypad7.rawValue,
    UIKeyboardHIDUsage.keypad8:Keyboard.KeyCodes.keypad8.rawValue,
    UIKeyboardHIDUsage.keypad9:Keyboard.KeyCodes.keypad9.rawValue,
    UIKeyboardHIDUsage.keyboardDownArrow:Keyboard.KeyCodes.downArrow.rawValue,
    UIKeyboardHIDUsage.keyboardUpArrow:Keyboard.KeyCodes.upArrow.rawValue,
    UIKeyboardHIDUsage.keyboardLeftArrow:Keyboard.KeyCodes.leftArrow.rawValue,
    UIKeyboardHIDUsage.keyboardRightArrow:Keyboard.KeyCodes.rightArrow.rawValue,
    UIKeyboardHIDUsage.keyboardSpacebar:Keyboard.KeyCodes.space.rawValue,
    UIKeyboardHIDUsage.keyboardReturn:Keyboard.KeyCodes.returnKey.rawValue,
    UIKeyboardHIDUsage.keyboardReturnOrEnter:Keyboard.KeyCodes.enterKey.rawValue,
    UIKeyboardHIDUsage.keyboardEscape:Keyboard.KeyCodes.escape.rawValue,
    UIKeyboardHIDUsage.keyboardLeftShift:Keyboard.KeyCodes.shift.rawValue,
    UIKeyboardHIDUsage.keyboardRightShift:Keyboard.KeyCodes.shift.rawValue
    //[UIKeyboardHIDUsage.keyboard:Keyboard.KeyCodes.a]
]

