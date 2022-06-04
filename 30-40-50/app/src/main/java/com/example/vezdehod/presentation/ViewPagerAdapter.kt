package com.example.vezdehod.presentation

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.request.RequestOptions
import com.example.vezdehod.R
import com.example.vezdehod.data.Story
import com.example.vezdehod.databinding.ItemStoryViewpagerBinding
import jp.wasabeef.glide.transformations.BlurTransformation


class ViewPagerAdapter(private val listener: ViewPagerAdapterListener) :
    ListAdapter<Story, ViewPagerAdapter.PagerViewHolder>(DIFF) {
    private companion object {
        val DIFF = object : DiffUtil.ItemCallback<Story>() {
            override fun areItemsTheSame(oldItem: Story, newItem: Story) =
                oldItem == newItem

            override fun areContentsTheSame(oldItem: Story, newItem: Story) =
                oldItem == newItem

        }
    }

    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): PagerViewHolder =
        PagerViewHolder(
            LayoutInflater.from(parent.context)
                .inflate(R.layout.item_story_viewpager, parent, false)
        )

    override fun onBindViewHolder(holder: PagerViewHolder, position: Int) {
        holder.bind(getItem(position))
    }

    inner class PagerViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        private val binding = ItemStoryViewpagerBinding.bind(view)

        init {
            binding.detailsButton.setOnClickListener {
                listener.onItemClick(getItem(bindingAdapterPosition))
            }
            binding.cityTextView.setTopStatusBarMargin()
        }

        fun bind(item: Story) = with(binding) {
            cityTextView.text = item.city
            dateTextView.text = item.date
            titleTextView.text = item.title
            descriptionTextView.text = item.description

            Glide.with(backgroundImageView).load(item.imageUrl)
                .apply(RequestOptions.bitmapTransform(BlurTransformation(30, 3)))
                .into(backgroundImageView)

            Glide.with(imageImageView).load(item.imageUrl)
                .into(imageImageView)
        }
    }

    fun interface ViewPagerAdapterListener {
        fun onItemClick(item: Story)
    }
}