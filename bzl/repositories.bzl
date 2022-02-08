load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def pcl_repositories():
    _maybe_repo(
        http_archive,
        name = "com_github_nelhage_rules_boost",
        sha256 = "b64e6f7e96c5b0d7ebcb74c5ee29ab879b8ef8c37581ed0be5ff6c23168da985",
        strip_prefix = "rules_boost-ed844db5990d21b75dc3553c057069f324b3916b",
        urls = ["https://github.com/nelhage/rules_boost/archive/ed844db5990d21b75dc3553c057069f324b3916b.tar.gz"],
    )

    _maybe_repo(
        http_archive,
        name = "eigen",
        build_file = "@rules_pcl//third_party:eigen.BUILD",
        sha256 = "a8d87c8df67b0404e97bcef37faf3b140ba467bc060e2b883192165b319cea8d",
        strip_prefix = "eigen-git-mirror-3.3.7",
        # NOTE: The official repo is hosted on gitlab, but gitlab appears to return a 406 error when
        # trying to fetch archives. So we are using the deprecated github mirror instead until
        # either bazel or gitlab fixes this issue.
        # See:
        #  https://github.com/bazelbuild/bazel/issues/11187
        #  https://stackoverflow.com/questions/60864626/cannot-fetch-eigen-with-bazel-406-not-acceptable
        urls = ["https://github.com/eigenteam/eigen-git-mirror/archive/3.3.7.tar.gz"],
    )

    _maybe_repo(
        http_archive,
        name = "net_zlib_zlib",
        sha256 = "6d4d6640ca3121620995ee255945161821218752b551a1a180f4215f7d124d45",
        build_file = "@rules_pcl//third_party:zlib.BUILD",
        strip_prefix = "zlib-cacf7f1d4e3d44d871b605da3b647f07d718623f",
        urls = [
            "https://mirror.bazel.build/github.com/madler/zlib/archive/cacf7f1d4e3d44d871b605da3b647f07d718623f.tar.gz",
            "https://github.com/madler/zlib/archive/cacf7f1d4e3d44d871b605da3b647f07d718623f.tar.gz",
        ],
    )

    _maybe_repo(
        http_archive,
        name = "org_libpng_libpng",
        build_file = "@rules_pcl//third_party:libpng.BUILD",
        sha256 = "7f415186d38ca71c23058386d7cf5135c8beda821ee1beecdc2a7a26c0356615",
        strip_prefix = "libpng-1.2.57",
        urls = [
            "https://github.com/glennrp/libpng/archive/v1.2.57.tar.gz",
            "https://mirror.bazel.build/github.com/glennrp/libpng/archive/v1.2.57.tar.gz",
        ],
    )

    _maybe_repo(
        http_archive,
        name = "pcl",
        build_file = "@rules_pcl//third_party:pcl.BUILD",
        strip_prefix = "pcl-59b667ffcca131568787fef1f7578879ce730668",
        urls = ["https://github.com/PointCloudLibrary/pcl/archive/59b667ffcca131568787fef1f7578879ce730668.tar.gz"],
    )

    _maybe_repo(
        http_archive,
        name = "qhull",
        build_file = "@rules_pcl//third_party:qhull.BUILD",
        sha256 = "cf7235b76244595a86b9407b906e3259502b744528318f2178155e5899d6cf9f",
        strip_prefix = "qhull-2019.1",
        urls = ["https://github.com/qhull/qhull/archive/2019.1.tar.gz"],
    )

def _maybe_repo(repo_rule, name, **kwargs):
    """A wrapper around repo rules to prevent adding a rule if it already exists, e.g. if it was
        already added to a user's WORKSPACE file by other dependencies.
    """
    if name not in native.existing_rules():
        repo_rule(name = name, **kwargs)
