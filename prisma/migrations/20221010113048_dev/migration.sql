/*
  Warnings:

  - Added the required column `question` to the `Question` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Question" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "question" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_Question" ("createdAt", "id", "updatedAt") SELECT "createdAt", "id", "updatedAt" FROM "Question";
DROP TABLE "Question";
ALTER TABLE "new_Question" RENAME TO "Question";
CREATE UNIQUE INDEX "Question_id_key" ON "Question"("id");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
