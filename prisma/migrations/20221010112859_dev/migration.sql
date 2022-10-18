/*
  Warnings:

  - Added the required column `isCorrect` to the `Answer` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Answer" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "value" TEXT NOT NULL,
    "isCorrect" BOOLEAN NOT NULL,
    "questionId" TEXT NOT NULL,
    CONSTRAINT "Answer_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES "Question" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Answer" ("id", "questionId", "value") SELECT "id", "questionId", "value" FROM "Answer";
DROP TABLE "Answer";
ALTER TABLE "new_Answer" RENAME TO "Answer";
CREATE UNIQUE INDEX "Answer_id_key" ON "Answer"("id");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
