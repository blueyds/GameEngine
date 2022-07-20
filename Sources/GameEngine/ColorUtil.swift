//
//  ColorUtil.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/29/22.
//

import simd

class ColorUtil {
	public static var randomColor: simd_float4 {
		simd_float4(Float.randomZeroToOne,
					Float.randomZeroToOne,
					Float.randomZeroToOne,
					1 )
	}
}
