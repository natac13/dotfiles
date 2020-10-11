#!/usr/bin/env bash

FONTS_DIR="${HOME}/.local/share/fonts"
if [ ! -d "${FONTS_DIR}" ]; then
    echo "mkdir -p $FONTS_DIR"
    mkdir -p "${FONTS_DIR}"
else
    echo "Found fonts dir $FONTS_DIR"
fi


##################################################
# Custom Font dependencies - MyOperatorMono
##################################################
# Fira Code install.
if [ ! -d "${FONTS_DIR}/firacode" ]; then
  mkdir -p "${FONTS_DIR}/firacode"
fi
for type in Bold Light Medium Regular Retina; do
  file_path="${FONTS_DIR}/firacode/FiraCode-${type}.ttf"
  file_url="https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true"
  if [ -f "${file_path}" ]; then
    rm $file_path
  fi;
  wget -O "${file_path}" "${file_url}"
done

# Script12BTRoman
if [ -f "${FONTS_DIR}/Script12BTRoman" ]; then
  rm "${FONTS_DIR}/Script12BTRoman"
fi
cp -u "${DOTFILES}/fonts/Script12BTRoman.ttf" "${FONTS_DIR}/Script12BTRoman.ttf"

# MyOperatorMono

cp -u "${DOTFILES}/fonts/MyOperatorMono/MyOperatorMono-Regular.ttf" "${FONTS_DIR}/MyOperatorMono/MyOperatorMono-Regular.ttf"
cp -u "${DOTFILES}/fonts/MyOperatorMono/MyOperatorMono-Light.ttf" "${FONTS_DIR}/MyOperatorMono/MyOperatorMono-Light.ttf"
cp -u "${DOTFILES}/fonts/MyOperatorMono/MyOperatorMono-Bold.ttf" "${FONTS_DIR}/MyOperatorMono/MyOperatorMono-Bold.ttf"
cp -u "${DOTFILES}/fonts/MyOperatorMono/MyOperatorMono-Italic.ttf" "${FONTS_DIR}/MyOperatorMono/MyOperatorMono-Italic.ttf"
##################################################
# Google Fonts
##################################################

# Oswald install.
if [ ! -d "${FONTS_DIR}/oswald" ]; then
  mkdir -p "${FONTS_DIR}/oswald"
fi

oswald_types=(
  Bold
  SemiBold
  Medium
  Regular
  Light
  ExtraLight
)

for oswald_type in "${oswald_types[@]}"; do
  file_path="${FONTS_DIR}/oswald/${oswald_type}.ttf"
  file_url="https://github.com/google/fonts/blob/master/ofl/oswald/static/Oswald-${oswald_type}.ttf?raw=true"
  if [  -f "${file_path}" ]; then
    rm $file_path
  fi;
    wget -O "${file_path}" "${file_url}"
done

# OpenSans install.
if [ ! -d "${FONTS_DIR}/opensans" ]; then
  mkdir -p "${FONTS_DIR}/opensans"
fi

opensans_types=(
  Bold
  BoldItalic
  ExtraBoldItalic
  Italic
  Light
  LightItalic
  Regular
  SemiBold
  SemiBoldItalic
)

for opensans_type in "${opensans_types[@]}"; do
  file_path="${FONTS_DIR}/opensans/${opensans_type}.ttf"
  file_url="https://github.com/google/fonts/blob/master/apache/opensans/OpenSans-${opensans_type}.ttf?raw=true"
  if [  -f "${file_path}" ]; then
    rm $file_path
  fi;
    wget -O "${file_path}" "${file_url}"
done

echo "fc-cache -f"
fc-cache -f
