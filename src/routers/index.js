const { Router } = require('express');
const { PrismaClient } = require('@prisma/client');
const { restart } = require('nodemon');
const prisma = new PrismaClient();
const router = Router();

router.get('/questions', (req, res) => {
    prisma.question.findMany({
        orderBy: [
            {
                createdAt: 'desc'
            }
        ],
        select: {
            id: true,
            question: true,
            answers: {
                take: 4,
                select: {
                    value: true,
                    isCorrect: true,
                }
            }
        }
    })
        .then(questions => res.status(200).json(questions))
        .catch(err => res.status(400).json({ error: err }));
});

router.delete('/questions/clear', (req, res) => {
    prisma.answer.deleteMany()
        .then(count => res.status(200).json({count}))
        .catch(err => console.error(err));
    prisma.question.deleteMany()
        .then(count => res.status(200).json({count}))
        .catch(err => console.error(err));
});

router.get('/questions/count', (req, res) => {
    prisma.question.findMany({
        orderBy: [
            {
                createdAt: 'desc'
            }
        ],
        select: {
            id: true,
            question: true,
            answers: {
                take: 4,
                select: {
                    value: true,
                    isCorrect: true,
                }
            }
        }
    })
        .then(questions => res.status(200).json(questions.length))
        .catch(err => res.status(400).json({ error: err }));
})

router.post('/questions/add', (req, res) => {
    const data = req.body;
    if (!data.question) return res.status(400).json({ error: 'Harap masukan pertanyaan yang benar!' });
    if (!data.answers) return res.status(400).json({ error: 'Masukan pilihan ganda minimal 4' });
    if (data.answers.length < 2) return res.status(400).json({ error: 'Answer harus lebih dari atau sama dengan 4' });
    for (const answer of data.answers) {
        if (!('isCorrect' in answer) || !('value' in answer)) return res.status(200).json({ error: 'Ada jawaban yang tidak memiliki property isCorrect' });
    };
    prisma.question.create({
        data: {
            question: data.question,
            answers: {
                create: data.answers
            }
        },
    })
        .then(async question => {
            const answers = prisma.answer.findMany({
                where: {
                    questionId: question.id,
                },
                orderBy: {
                    id: 'desc',
                }
            });
            return res.status(200).json({
                question: question.question,
                answers,
            })
        })
        .catch(err => res.status(400).json({ error: err }));

})

router.delete('/questions/delete', (req, res) => {
    prisma.question.delete({
        where: {
            id: req.params.id
        },
        include: {
            answers: true
        }
    })
        .then(success => res.status(200).json({ status: 'Success!' }))
        .catch(err => res.status(400).json({ error: err }));
});

router.get('/leaderboard', (req, res) => {
    prisma.leaderboard.findMany({
        orderBy: {
            score: 'desc'
        }
    })
        .then(leaderboard => res.status(200).json(leaderboard))
        .catch(err => res.status(400).json({error: err}));
});

router.post('/leaderboard/add', (req, res) => {
    const data = req.body;
    if (!data.teamName) return; 
    if (!data.score) return;
    prisma.leaderboard.create({
        data: {
            teamName: data.teamName,
            score: data.score,
        }
    })
        .then(leaderboard => res.status(200).json(leaderboard))
        .catch(err => console.log(err));
});

router.delete('/leaderboard/clear', (req, res) => {
    prisma.leaderboard.deleteMany()
        .then(count => res.status(200).json(count))
        .catch(err => console.error(err));
})

module.exports = router;