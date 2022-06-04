package com.example.vezdehod.presentation

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.WindowCompat
import by.kirich1409.viewbindingdelegate.viewBinding
import com.example.vezdehod.R
import com.example.vezdehod.data.StoryDataSource
import com.example.vezdehod.databinding.ActivityMainBinding
import com.google.android.material.tabs.TabLayoutMediator

class MainActivity : AppCompatActivity() {

    private val viewBinding by viewBinding(ActivityMainBinding::bind, R.id.rootLayout)
    private val viewPagerAdapter = ViewPagerAdapter {
        startActivity(
            Intent(Intent.ACTION_VIEW).apply {
                data = Uri.parse(it.link)
            }
        )
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        initView()
    }

    private fun initView() = with(viewBinding) {
        tabLayout.setTopStatusBarMargin()

        val viewPager = viewBinding.viewPager
        viewPager.adapter = viewPagerAdapter
        viewPagerAdapter.submitList(StoryDataSource.stories)

        TabLayoutMediator(
            viewBinding.tabLayout,
            viewPager
        ) { _, _ -> }.attach()
    }
}