from mw2fcitx.tweaks.moegirl import tweak_opencc_t2s, tweaks

exports = {
    "source": {
        # "api_path": "https://zh.moegirl.org.cn/api.php",
        "file_path": [
            "titles.txt",  # use file-based title source for now
            "extras/pcr.txt",
        ]
    },
    "tweaks": [*tweaks, tweak_opencc_t2s],
    "converter": {"use": "opencc", "kwargs": {"fixfile": "fixfile.json"}},
    "generator": [
        {
            "use": "rime",
            "kwargs": {"version": "0.0.1", "output": "moegirl.dict.yaml"},
        }
    ],
}
