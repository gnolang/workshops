package main

import (
	_ "embed"
	"html/template"
)

// https://revealjs.com/config/
// pointers everywhere so we don't accidentally copy over stuff we don't need.
type revealConfig struct {
	Controls                        *bool     `yaml:"controls" json:"controls,omitempty"`
	ControlsTutorial                *bool     `yaml:"controlsTutorial" json:"controlsTutorial,omitempty"`
	ControlsLayout                  *string   `yaml:"controlsLayout" json:"controlsLayout,omitempty"`
	ControlsBackArrows              *string   `yaml:"controlsBackArrows" json:"controlsBackArrows,omitempty"`
	Progress                        *bool     `yaml:"progress" json:"progress,omitempty"`
	SlideNumber                     *bool     `yaml:"slideNumber" json:"slideNumber,omitempty"`
	ShowSlideNumber                 *string   `yaml:"showSlideNumber" json:"showSlideNumber,omitempty"`
	HashOneBasedIndex               *bool     `yaml:"hashOneBasedIndex" json:"hashOneBasedIndex,omitempty"`
	Hash                            *bool     `yaml:"hash" json:"hash,omitempty"`
	RespondToHashChanges            *bool     `yaml:"respondToHashChanges" json:"respondToHashChanges,omitempty"`
	JumpToSlide                     *bool     `yaml:"jumpToSlide" json:"jumpToSlide,omitempty"`
	History                         *bool     `yaml:"history" json:"history,omitempty"`
	Keyboard                        *bool     `yaml:"keyboard" json:"keyboard,omitempty"`
	KeyboardCondition               *string   `yaml:"keyboardCondition" json:"keyboardCondition,omitempty"`
	DisableLayout                   *bool     `yaml:"disableLayout" json:"disableLayout,omitempty"`
	Overview                        *bool     `yaml:"overview" json:"overview,omitempty"`
	Center                          *bool     `yaml:"center" json:"center,omitempty"`
	Touch                           *bool     `yaml:"touch" json:"touch,omitempty"`
	Loop                            *bool     `yaml:"loop" json:"loop,omitempty"`
	Rtl                             *bool     `yaml:"rtl" json:"rtl,omitempty"`
	NavigationMode                  *string   `yaml:"navigationMode" json:"navigationMode,omitempty"`
	Shuffle                         *bool     `yaml:"shuffle" json:"shuffle,omitempty"`
	Fragments                       *bool     `yaml:"fragments" json:"fragments,omitempty"`
	FragmentInURL                   *bool     `yaml:"fragmentInURL" json:"fragmentInURL,omitempty"`
	Embedded                        *bool     `yaml:"embedded" json:"embedded,omitempty"`
	Help                            *bool     `yaml:"help" json:"help,omitempty"`
	Pause                           *bool     `yaml:"pause" json:"pause,omitempty"`
	ShowNotes                       *bool     `yaml:"showNotes" json:"showNotes,omitempty"`
	AutoPlayMedia                   *bool     `yaml:"autoPlayMedia" json:"autoPlayMedia,omitempty"`
	PreloadIframes                  *bool     `yaml:"preloadIframes" json:"preloadIframes,omitempty"`
	AutoAnimate                     *bool     `yaml:"autoAnimate" json:"autoAnimate,omitempty"`
	AutoAnimateMatcher              *string   `yaml:"autoAnimateMatcher" json:"autoAnimateMatcher,omitempty"`
	AutoAnimateEasing               *string   `yaml:"autoAnimateEasing" json:"autoAnimateEasing,omitempty"`
	AutoAnimateDuration             *int      `yaml:"autoAnimateDuration" json:"autoAnimateDuration,omitempty"`
	AutoAnimateUnmatched            *bool     `yaml:"autoAnimateUnmatched" json:"autoAnimateUnmatched,omitempty"`
	AutoAnimateStyles               *[]string `yaml:"autoAnimateStyles" json:"autoAnimateStyles,omitempty"`
	AutoSlide                       *int      `yaml:"autoSlide" json:"autoSlide,omitempty"`
	AutoSlideStoppable              *bool     `yaml:"autoSlideStoppable" json:"autoSlideStoppable,omitempty"`
	DefaultTiming                   *int      `yaml:"defaultTiming" json:"defaultTiming,omitempty"`
	MouseWheel                      *bool     `yaml:"mouseWheel" json:"mouseWheel,omitempty"`
	PreviewLinks                    *bool     `yaml:"previewLinks" json:"previewLinks,omitempty"`
	PostMessage                     *bool     `yaml:"postMessage" json:"postMessage,omitempty"`
	PostMessageEvents               *bool     `yaml:"postMessageEvents" json:"postMessageEvents,omitempty"`
	FocusBodyOnPageVisibilityChange *bool     `yaml:"focusBodyOnPageVisibilityChange" json:"focusBodyOnPageVisibilityChange,omitempty"`
	Transition                      *string   `yaml:"transition" json:"transition,omitempty"`
	TransitionSpeed                 *string   `yaml:"transitionSpeed" json:"transitionSpeed,omitempty"`
	BackgroundTransition            *string   `yaml:"backgroundTransition" json:"backgroundTransition,omitempty"`
	PdfMaxPagesPerSlide             *int      `yaml:"pdfMaxPagesPerSlide" json:"pdfMaxPagesPerSlide,omitempty"`
	PdfSeparateFragments            *bool     `yaml:"pdfSeparateFragments" json:"pdfSeparateFragments,omitempty"`
	PdfPageHeightOffset             *int      `yaml:"pdfPageHeightOffset" json:"pdfPageHeightOffset,omitempty"`
	ViewDistance                    *int      `yaml:"viewDistance" json:"viewDistance,omitempty"`
	MobileViewDistance              *int      `yaml:"mobileViewDistance" json:"mobileViewDistance,omitempty"`
	Display                         *string   `yaml:"display" json:"display,omitempty"`
	HideInactiveCursor              *bool     `yaml:"hideInactiveCursor" json:"hideInactiveCursor,omitempty"`
	HideCursorTime                  *int      `yaml:"hideCursorTime" json:"hideCursorTime,omitempty"`

	Width    *int     `yaml:"width" json:"width,omitempty"`
	Height   *int     `yaml:"height" json:"height,omitempty"`
	Margin   *float64 `yaml:"margin" json:"margin,omitempty"`
	MinScale *float64 `yaml:"minScale" json:"minScale,omitempty"`
	MaxScale *float64 `yaml:"maxScale" json:"maxScale,omitempty"`
}

type combinedConfig struct {
	Title        string `yaml:"title"`
	Theme        string `yaml:"theme"`
	revealConfig `yaml:",inline"`
}

func (c combinedConfig) renderData() renderData {
	r := renderData{
		Title:  c.Title,
		Theme:  c.Theme,
		Config: c.revealConfig,
	}
	r.ApplyDefaults()
	return r
}

type renderData struct {
	Title        string
	Theme        string
	Presentation string
	Config       revealConfig
}

func (r *renderData) ApplyDefaults() {
	if r.Title == "" {
		r.Title = "Gno Presentation"
	}
	if r.Theme == "" {
		r.Theme = "black"
	}
	if r.Config.Hash == nil {
		r.Config.Hash = ptrTo(true)
	}
	if r.Config.HashOneBasedIndex == nil {
		r.Config.HashOneBasedIndex = ptrTo(true)
	}
}

func ptrTo[T any](v T) *T {
	return &v
}

//go:embed template.html
var tplData string

var tpl = template.Must(template.New("").Parse(tplData))
