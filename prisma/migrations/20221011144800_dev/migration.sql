/*
  Warnings:

  - You are about to drop the `Team` table. If the table is not empty, all the data it contains will be lost.
  - You are about to alter the column `score` on the `Leaderboard` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Int`.

*/
-- DropIndex
DROP INDEX "Team_id_key";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Team";
PRAGMA foreign_keys=on;

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Leaderboard" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "teamName" TEXT NOT NULL,
    "score" INTEGER NOT NULL
);
INSERT INTO "new_Leaderboard" ("id", "score", "teamName") SELECT "id", "score", "teamName" FROM "Leaderboard";
DROP TABLE "Leaderboard";
ALTER TABLE "new_Leaderboard" RENAME TO "Leaderboard";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
