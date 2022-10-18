-- CreateTable
CREATE TABLE "Team" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "points" BIGINT NOT NULL
);

-- CreateTable
CREATE TABLE "Answer" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "value" TEXT NOT NULL,
    "questionId" TEXT NOT NULL,
    CONSTRAINT "Answer_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES "Question" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Question" (
    "id" TEXT NOT NULL PRIMARY KEY
);

-- CreateIndex
CREATE UNIQUE INDEX "Team_id_key" ON "Team"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Answer_id_key" ON "Answer"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Question_id_key" ON "Question"("id");
