From 17f1d1501d0e9319a5860db5082dacbe84a89720 Mon Sep 17 00:00:00 2001
From: microcai <microcai@fedoraproject.org>
Date: Sun, 8 Jan 2012 11:00:59 +0800
Subject: [PATCH] use glib.h

---
 src/tomboykeybinder.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/tomboykeybinder.h b/src/tomboykeybinder.h
index 0516eea..182542d 100644
--- a/src/tomboykeybinder.h
+++ b/src/tomboykeybinder.h
@@ -2,7 +2,7 @@
 #ifndef __TOMBOY_KEY_BINDER_H__
 #define __TOMBOY_KEY_BINDER_H__
 
-#include <glib/gtypes.h>
+#include <glib.h>
 
 G_BEGIN_DECLS
 
-- 
1.7.8.2

