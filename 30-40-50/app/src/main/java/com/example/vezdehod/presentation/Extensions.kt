package com.example.vezdehod.presentation

import android.view.View
import android.view.ViewGroup
import androidx.core.view.marginTop


fun View.setTopStatusBarMargin() {
    val topMargin = this.marginTop
    val params = layoutParams as ViewGroup.MarginLayoutParams
    params.setMargins(
        params.leftMargin,
        topMargin + getStatusBarHeightInPixels(),
        params.rightMargin,
        params.bottomMargin
    )
    this.layoutParams = params
}

private fun View.getStatusBarHeightInPixels(): Int {
    var statusBarHeight = 0
    val resourceId = resources.getIdentifier("status_bar_height", "dimen", "android")
    if (resourceId > 0) {
        statusBarHeight = resources.getDimensionPixelSize(resourceId)
    }

    return statusBarHeight
}