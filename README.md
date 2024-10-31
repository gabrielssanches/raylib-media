![Version](https://img.shields.io/badge/raylib-v5.0-informational) <!-- ![License](https://img.shields.io/github/license/cloudofoz/raylib-media) -->

> **Note**: This library is currently in **beta** and requires thorough testing. Please report any issues or feedback to help improve stability.

## Introduction

**raylib-media** is a clean, user-friendly library for [raylib](https://www.raylib.com/) that seamlessly integrates **audio** and **video** streaming capabilities through [FFmpeg](https://ffmpeg.org/about.html) **libav\*** libraries.

<p align="center">
  <img src="res/rmedia_icon.svg" alt="raylib-media icon" width="256" height="256">
</p>

## Core Features
- Simple, effective, and customizable
- Direct access to video `Texture` and `AudioStream` for streamlined media handling
- Audio and video synchronization through specialized queues and buffers
- Media seeking and looping functionality
- Supports all formats compatible with the linked FFmpeg build
- Efficient memory use, with no direct allocations outside the `LoadMedia` function logic
