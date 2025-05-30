#!/usr/bin/env bash

# Taken from
# https://github.com/qvint/ungoogled-chromium-fedora/commit/a68fdd679566da5134d916776f14e00c8e6a8042

self="$(readlink -f "${0}")"
self_dir="$(dirname "${self}")"
dict_utility="${self_dir}/convert_dict"

# Defaults.
hunspell_dicts_dir="/usr/share/myspell"
user_data_dir="${HOME}/.config/thorium"

# Parse command-line arguments.
while [[ $# -gt 0 ]]; do
  arg_name="${1}"

  case "${arg_name}" in
    "--hunspell-dicts-dir")
      hunspell_dicts_dir="${2}"
      shift; shift
      ;;
    "--user-data-dir")
      user_data_dir="${2}"
      shift; shift
      ;;
    *)
      echo -n "Usage: ungoogled-chromium-update-dicts "
      echo "[--hunspell-dicts-dir DIR] [--user-data-dir DIR]"
      exit 1
  esac
done

# List all chromium language entries.
chromium_language_entries="$("${dict_utility}" list)"

# Iterate through chromium language entries and make *.bdic files.
chromium_dicts_dir="${user_data_dir}/Dictionaries"
mkdir -p "${chromium_dicts_dir}"
while read -r chromium_language_entry; do
  while read \
    chromium_language \
    chromium_language_region \
    chromium_bdic_basename; do

    hunspell_language_region="${chromium_language_region//-/_}"
    aff_path="${hunspell_dicts_dir}/${hunspell_language_region}.aff"
    dic_path="${hunspell_dicts_dir}/${hunspell_language_region}.dic"
    bdic_path="${chromium_dicts_dir}/${chromium_bdic_basename}"

    if \
      [[ -f "${aff_path}" ]] && \
      [[ -f "${dic_path}" ]] && \
      [[ ! -f "${bdic_path}" ]]; then
      "${dict_utility}" convert "${aff_path}" "${dic_path}" "${bdic_path}"
    fi
  done <<< "${chromium_language_entry}"
done <<< "${chromium_language_entries}"
