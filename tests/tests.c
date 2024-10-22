#include <stdio.h>
#include <stdlib.h>
//#include "libos.h"
#include <stdint.h>

//#define NULL ((void*)0) 

typedef struct PCB {
    uint64_t sp;
    uint32_t pid;
    struct PCB *next;
} PCB_t;

typedef struct {
    PCB_t *head;
    PCB_t *tail;
} PCB_Q_t;

void enqueue(PCB_Q_t *q, PCB_t *pcb) {
    // if the queue has nothing in it
    if (q->tail == NULL) {
        q->head = q->tail = pcb;
        pcb->next = NULL;
        return;
    }

    // otherwise add pcb to the end of the queue
    q->tail->next = pcb;
    q->tail = pcb;
    q->tail->next = NULL;
}

PCB_t *dequeue(PCB_Q_t *q) {
    // if queue is empty
    if (q->tail == NULL) {
        return NULL;
    }

    // store the head of queue and update head
    PCB_t *temp = q->head;
    q->head = q->head->next;

    if (q->head == NULL)
        q->tail = NULL;

    return temp;
}

// Test function declarations
void test_enqueue_dequeue();
void test_dequeue_empty_queue();
void test_multiple_enqueues();
void test_enqueue_dequeue_single();
void test_dequeue_until_empty();

int main() {
    test_enqueue_dequeue();
    test_dequeue_empty_queue();
    test_multiple_enqueues();
    test_enqueue_dequeue_single();
    test_dequeue_until_empty();
    return 0;
}

// Test for enqueue and dequeue functionality
void test_enqueue_dequeue() {
    PCB_Q_t queue = {NULL, NULL};
    PCB_t *pcb1 = (PCB_t *)malloc(sizeof(PCB_t));
    pcb1->pid = 1;
    enqueue(&queue, pcb1);
    PCB_t *deq1 = dequeue(&queue);

    printf("Test Enqueue/Dequeue: ");
    if (deq1 && deq1->pid == 1) {
        printf("Passed\n");
    } else {
        printf("Failed\n");
    }
    free(deq1);
}

// Test for dequeuing from an empty queue
void test_dequeue_empty_queue() {
    PCB_Q_t queue = {NULL, NULL};
    PCB_t *deq = dequeue(&queue);

    printf("Test Dequeue from Empty Queue: ");
    if (deq == NULL) {
        printf("Passed\n");
    } else {
        printf("Failed\n");
    }
}

// Test for multiple enqueues and then dequeues
void test_multiple_enqueues() {
    PCB_Q_t queue = {NULL, NULL};
    for (int i = 1; i <= 5; i++) {
        PCB_t *pcb = (PCB_t *)malloc(sizeof(PCB_t));
        pcb->pid = i;
        enqueue(&queue, pcb);
    }

    printf("Test Multiple Enqueues: ");
    for (int i = 1; i <= 5; i++) {
        PCB_t *deq = dequeue(&queue);
        if (deq == NULL || deq->pid != i) {
            printf("Failed at value %d\n", i);
            return;
        }
        free(deq);
    }
    printf("Passed\n");
}

// Test enqueue and dequeue with a single item
void test_enqueue_dequeue_single() {
    PCB_Q_t queue = {NULL, NULL};
    PCB_t *pcb = (PCB_t *)malloc(sizeof(PCB_t));
    pcb->pid = 42;
    enqueue(&queue, pcb);
    PCB_t *deq = dequeue(&queue);

    printf("Test Enqueue/Dequeue Single Item: ");
    if (deq && deq->pid == 42) {
        printf("Passed\n");
    } else {
        printf("Failed\n");
    }
    free(deq);
}

// Test dequeue until the queue is empty
void test_dequeue_until_empty() {
    PCB_Q_t queue = {NULL, NULL};
    for (int i = 1; i <= 3; i++) {
        PCB_t *pcb = (PCB_t *)malloc(sizeof(PCB_t));
        pcb->pid = i;
        enqueue(&queue, pcb);
    }

    printf("Test Dequeue Until Empty: ");
    for (int i = 1; i <= 3; i++) {
        PCB_t *deq = dequeue(&queue);
        if (deq == NULL || deq->pid != i) {
            printf("Failed at value %d\n", i);
            return;
        }
        free(deq);
    }

    // Check if queue is empty
    PCB_t *deq = dequeue(&queue);
    if (deq == NULL) {
        printf("Passed\n");
    } else {
        printf("Failed\n");
    }
}
