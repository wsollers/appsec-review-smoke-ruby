# Changelog

All notable changes to this project are documented in this file. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- Reports controller with a `show` action.
- Bundler manifest locking rack, sinatra, kramdown and tzinfo.

### Security

- 2026-01-21: Upgraded tzinfo from 1.2.9 to 1.2.10 (GHSA-5cm2-9h8c-rvfx, CVE-2022-31163, arbitrary file load through a crafted time zone identifier).
