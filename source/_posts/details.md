---
title: 代码复杂度
date: 2022.11.20
updated: 2022.11.20
comments:
description:
keywords:
top_img: https://img-cnd.noel.ga/blog/covers/1.jpg
mathjax:
katex:
aside:
aplayer:
highlight_shrink:
categories: 
  - tasks
tags:
  - complexity
---

## 1.程序长度复杂度c1

### Halstead 软件科学法（Halstead 复杂度）

#### 1 什么是Halstead 复杂度

   Halstead 复杂度 (Maurice H. Halstead, 1977) 是软件科学提出的第一个计算机软件的分析“定律”，用以确定计算机软件开发中的一些定量规律。Halstead 复杂度是根据程序中语句行的操作符和操作数的数量来计算得出的。操作符和操作数与程序复杂度成正相关，即操作符和操作数的量越大，程序结构就越复杂。

#### 2 Halstead 复杂度要素

【1】操作符，编程语言保留字（int、if）、函数调用、运算符（+、-）、分隔符（分号、括号）等

【2】操作数，常数、变量等

#### 3 Halstead 复杂度计算

  关于Halstead复杂度，有多个术语来衡量。用 n1 表示程序中不同的操作符个数，n2 表示程序中不同的操作数个数，N1 表示程序中出现的操作符总数，N2表示程序中出现的操作数总数。则Halstead复杂度几个标准计算如下。

名称	计算公式	含义
程序词汇表长度(n)	n=n1+n2	
程序长度(N)	N=N1+N2	
程序预测长度(N^)	N^=n1 log2 n1 + n2 log2 n2	预估程序的实际长度
程序体积或容量(V)	V = Nlog2 (n)	程序在词汇上的复杂性
程序级别(L^)	L^ = (2/n1) × (n2 /N2)	程序最紧凑形式的程序量与实际程序量比值，反映了程序的效率
程序难度(D)	D=1/L^	实现算法的困难程度
编程工作量(L^ )	Lʹ = L^ × L^ × V	
编程时间( T^)	T^ = E/(S × f)	
平均语句(X)	X=N/语句数	
程序错误数预测值(B)	B = V/3000	

#### 4 Halstead 复杂度优缺点

##### 【1】优点

计算方法简单
不需要对程序进行深层次的分析，就能够预测程序错误率，预测维护工作量
复杂度计算与所用的高级程序设计语言类型无关

##### 【2】缺点

仅仅考虑程序数据量和程序体积，未考虑到程序控制流的情况
不能从根本上反映程序复杂性

**可参考**: [halstead计算复杂度](https://github.com/aametwally/Halstead-Complexity-Measures)

```c
#include <stdio.h> 
// Computed mu1 complexity of this module: 16 
int main() {
	int i ;
	for (i=0;i<15;i++) {
		printf ("iteration %d\n",i);
	}
	return 0;
}
			//Listing 1: Example of µ1 complexity.
```



## 2.圈复杂度c2

### T.McCabe度量法（圈复杂度）

#### 1 什么是圈复杂度

  圈复杂度(Cyclomatic Complexity)是一种代码复杂度的衡量标准，由 Thomas McCabe 于 1976年定义。它可以用来衡量一个模块判定结构的复杂程度，数量上表现为独立现行路径条数，也可理解为覆盖所有的可能情况最少使用的测试用例数。圈复杂度大说明程序代码的判断逻辑复杂，可能质量低且难于测试和维护。程序的可能错误和高的圈复杂度有着很大关系。[百度百科]

#### 2 圈复杂度计算

  圈复杂度主要与分支语句（if、else、switch ）的数量成正相关，即程序分支语句越多，圈复杂度越大，也就是程序复杂度越大。如果一段源码中不包含控制流语句（条件或决策点），即此段代码只有一条路径，那么代码的圈复杂度为1。如果一段代码中仅包含一个if语句，且if语句仅有一个条件，那么这段代码的圈复杂度为2；包含两个嵌套的if语句，或是一个if语句有两个条件的代码块的圈复杂度为3。

  圈复杂度的计算有三种方式，这三种方式根据程序流图进行计算，是很容易理解的。以下图程序流图为例。

![image-20221120110335107](https://gitea.noel.ga/picgo/lxy-img/raw/branch/master/img/202211201103194.png)

##### 【1】V(G) = e - n + 2p

  其中，e 表示控制流图中的边数量（即程序顺序结构的部分），n 表示控制流图中的判断节点数量（执行节点），控制流图是联通的，p取值为1。所以上图的圈复杂度为：V(G)=7-6+2=3。

##### 【2】V(G) = n+1

  其中，n表示控制流图判断节点数量。则上图圈复杂度为：V(G)=2+1=3。

##### 【3】V(G)=s

  其中，s表示程序流图将平面划分的区域数量，上图平面区域数量为3（内部2个，外围1个），则V(G)=3。

#### 3 圈复杂度参考标准

  McCabe&Associates 公司建议尽可能使 V（G） ≤ 10。国家标准技术研究所（NIST）认为在一些特定情形下，模块圈复杂度上限放宽到15。

0≤ V（G） ≤ 10，代码质量不错
11 ≤ V（G） ≤ 15，可能存在需要拆分的代码，应当尽可能考虑重构
V（G） ≥ 16，代码必须进行重构、

**可参考**：[GitHub - ephox-gcc-plugins/cyclomatic_complexity：基于 gcc 内部表示计算函数的圈复杂度。](https://github.com/ephox-gcc-plugins/cyclomatic_complexity)

```c
#include <stdio.h> 
/∗ Computed mu2 complexity of this module: 4∗/ 
/∗ Computed mu3 complexity of this module: 2∗/
int main() {
	int i = 0;
	int j = 0;
	while (i<16) {
		printf ("iteration %d\n", i);
		if (i>2) {
			j+=i;
		}
	}
	if ( j >= 3) {
		printf ("j is greater than 3\n");
	}
	return 0;
}
		//Listing 2: Example of µ2 and µ3 complexity.
```



## 3.嵌套复杂度c3

> 3.1.3 The µ3 complexity (Nesting complexity)
> 	The nesting complexity defined by Harrison [7] uses the CFG of the program to consider the nesting of nodes when measuring the complexity of a program. For each node of the control flow, the complexity of the program is incremented by the Halstead’s complexity of this node plus the number of nodes within its range plus the Halstead’s complexity of each of theses nodes.
> 	Implementing the actual definition of Harrison’s complexity would introduce redundancy with the Halstead’s complexity (the µ1 complexity) and McCabe’s complexity as this complexity tries to replace both of these complexities. Therefore, we redefined the µ3 complexity of a module as the maximum depth of predicate nesting in the module. This new definition will complement MacCabe’s complexity. MacCabe’s complexity will stimulate the appearance of predicates and our µ3 complexity will stimulate their nesting (and only their nesting). Like in the compute_mu1_complexity and the compute_mu2_complexity passes, the AST of the module is analysed to find the maximum depth of the module’s statements in the module. The internal representation of Pips representing switch statement as nested test statements, the depth of a case is its rank in the list of cases of the switch statement. On the example of figure 2, the calculated µ3 complexity of the main module is 2.

3.1.3 µ3复杂性（嵌套复杂性）
	哈里森[7]定义的嵌套复杂度在测量程序的复杂度时使用程序的CFG来考虑节点的嵌套。对于控制流的每个节点，程序的复杂度由该节点的Halstead复杂度加上其范围内的节点数量加上每个节点的Halstead复杂度来增加。
	实施Harrison复杂度的实际定义会引入Halstead复杂度（µ1复杂度）和McCabe复杂度的冗余，因为这种复杂度试图取代这两种复杂度。因此，我们将模块的μ3复杂度重新定义为模块中谓词嵌套的最大深度。这个新定义将补充MacCabe的复杂性。MacCabe的复杂性将刺激谓词的出现，而我们的µ3复杂性将刺激它们的嵌套（而且只是嵌套）。就像在compute_mu1_complexity和compute_mu2_complexity传递中，模块的AST被分析，以找到模块中语句的最大深度。Pips的内部表示法将switch语句作为嵌套的测试语句，一个案例的深度是它在switch语句的案例列表中的等级。在图2的例子中，计算出的主模块的µ3复杂度为2。

通过www.DeepL.com/Translator（免费版）翻译



3.1.3 µ3复杂度（嵌套复杂度）

​	 Harrison[7]定义的嵌套复杂度在衡量程序的复杂度时使用程序的CFG来考虑节点的嵌套。对于控制流的每个节点，程序的复杂性增加了该节点的 Halstead 复杂性加上其范围内的节点数加上每个节点的 Halstead 复杂性。

 实施 Harrison 复杂度的实际定义会引入 Halstead 复杂度（µ1 复杂度）和 McCabe 复杂度的冗余，因为这种复杂度试图取代这两种复杂度。因此，我们将一个模块的μ3复杂度重新定义为该模块中谓词嵌套的最大深度。这个新定义将补充 MacCabe 的复杂性。 MacCabe 的复杂性会刺激谓词的出现，而我们的 µ3 复杂性会刺激它们的嵌套（而且只是它们的嵌套）。就像在 compute_mu1_complexity 和 compute_mu2_complexity passes 中一样，分析模块的 AST 以找到模块语句在模块中的最大深度。 Pips的内部表示将switch语句表示为嵌套的测试语句，一个case的深度就是它在switch语句的case列表中的排名。在图 2 的示例中，计算出的主模块的 µ3 复杂度为 2。

## 4.数据流复杂度c4

[数据流分析_z2664836046的博客-CSDN博客_数据流分析](https://blog.csdn.net/z2664836046/article/details/88742210)

> 3.1.4 The µ4 complexity (Data flow complexity)
> 	The µ4 complexity reflects the data flow complexity by adding the distances between the declaration of variables and their actual usage. For instance, global variable are usually harder to manipulate than local one and more generally, the longer a variable’s scope is, the more complicated it is for an attacker to track the variable manipulation. The goal of the µ4 complexity is therefore to count the number of variables that are defined outside of the blocks where they are used in (e.g. global variables, same variables used in different blocks). Here, blocks are semantical blocks of the module, and although it would be more accurate for the splitting to be adapted to the given module semantic, we had to decide for a splitting strategy that would be the same for every module that can be met since we want the pass to be completely automatic.
> 	In practice, the splitting strategy we selected operates as follows : loops (condition and body), tests branches and syntax blocks (parts of code between brackets) are considered as atomic blocks. Moreover, when a loop, test or black statement ends, a new block is opened. Loops, tests and syntax blocks constitute natural semantic blocks with their own coherence, and a variable used in two areas of the code separated by a block is harder to estimate as it could have been modified in that block. This splitting pattern is easily applied when given the module’s AST and offers an acceptable solution, although not optimal (an optimal splitting could be found by adapting the splitting more precisely to the given program), to the
> splitting problem.
> 	When the module has been split into blocks, its µ4 complexity is the sum of the µ4 complexity of its blocks. The µ4 complexity of a block is the number of variables used but not defined in this block. If a same variable is used more than once in a block, it will we counted every time it is used without being defined in the current block. Remark: This definition of the data flow complexity considers variable affectation as variable usage and not as variable definition. Also, other binding operations might be considered in the reduction of the µ4 complexity In the example on listing 3, the computed µ4 complexity of the main module is 15.

3.1.4 µ4复杂性（数据流复杂性）
	µ4复杂度反映了数据流复杂度，通过增加变量的声明和实际使用之间的距离 变量的声明和它们的实际使用之间的距离。例如，全局变量通常比局部变量更难操作。更普遍的是，一个变量的范围越长，攻击者跟踪变量的难度就越大。变量操作的复杂性。因此，µ4复杂性的目标是计算变量的数量。的数量（例如全局变量、在不同区块中使用的相同变量）。在不同的块中使用）。这里的块是指模块的语义块，尽管对模块进行分割会更准确。尽管根据给定的模块语义进行拆分会更准确，但我们必须决定采用一种对每个模块都相同的拆分策略。我们必须决定一个对每个模块都相同的分割策略，因为我们希望这个通道是完全 自动的。
	在实践中，我们选择的拆分策略如下：循环（条件和主体），测试 分支和语法块（括号内的代码部分）被认为是原子块。此外。当一个循环、测试或黑色语句结束时，一个新的块被打开。循环、测试和句法块构成 循环、测试和语法块构成了自然的语义块，有其自身的连贯性，而在代码的两个区域中使用的一个变量被一个块隔开 被一个块隔开的变量更难估计，因为它可能在该块中被修改过。这种分割模式是 当给定模块的AST时，这种分割模式很容易应用，并提供了一个可接受的解决方案，尽管不是最佳的（一个 最佳的分割方式可以通过对给定程序进行更精确的分割而找到），以解决
分割问题。
	当模块被分割成块时，其µ4复杂度是其块的µ4复杂度之和。的总和。一个块的µ4复杂度是指在这个块中使用但没有定义的变量的数量。如果同一个变量在一个块中使用了多次，那么它每次被使用时都会被计算在内，而不在当前块中定义。被定义在当前块中。备注。这个数据流复杂性的定义将变量 影响作为变量的使用，而不是作为变量的定义。此外，其他的绑定操作也可能被考虑到 在列表3的例子中，计算出的主模块的µ4复杂度是15。是15。

通过www.DeepL.com/Translator（免费版）翻译



3.1.4 µ4复杂度（数据流复杂度）

​	µ4 复杂度通过添加变量声明与其实际使用之间的距离来反映数据流的复杂度。例如，全局变量通常比局部变量更难操纵，更一般地说，变量的范围越长，攻击者跟踪变量操纵就越复杂。因此，µ4 复杂度的目标是计算在使用它们的块之外定义的变量的数量（例如，全局变量、在不同块中使用的相同变量）。在这里，块是模块的语义块，虽然根据给定的模块语义进行拆分会更准确，但我们必须决定一个拆分策略，该策略对于每个可以满足的模块都是相同的，因为我们希望通行证是完全自动的。

​	 在实践中，我们选择的拆分策略操作如下：循环（条件和主体）、测试分支和语法块（括号之间的代码部分）被视为原子块。此外，当循环、测试或黑色语句结束时，将打开一个新块。循环、测试和语法块构成了具有自身连贯性的自然语义块，并且在由块分隔的代码的两个区域中使用的变量更难估计，因为它可能已在该块中被修改。当给定模块的 AST 并提供可接受的解决方案时，这种拆分模式很容易应用，尽管不是最优的（通过更精确地适应给定程序的拆分可以找到最佳拆分），到 拆分问题。 

​	当模块被分成块时，它的 µ4 复杂度是它的块的 µ4 复杂度的总和。块的 µ4 复杂度是该块中使用但未定义的变量数。如果同一个变量在一个块中被多次使用，我们将在每次使用它而没有在当前块中定义时对其进行计数。备注：这个数据流复杂度的定义将变量影响视为变量使用而不是变量定义。此外，在降低 µ4 复杂度时可能会考虑其他绑定操作。在清单 3 的示例中，计算出的主模块的 µ4 复杂度为 15。

## 5.扇入/扇出复杂度c5

扇入、扇出表示函数之间的调用关系。

扇入指直接调用该模块的上级模块的个数；扇出指该模块直接调用的下级模块的个数。

扇入大表示模块的复用程度高；扇出大表示模块的复杂度高。

> 3.1.5 The µ5 complexity (Fan-in/out complexity)
> 	Henry and kafura defined a software measure based on information flow [8] as length∗(f anin ∗f anout)∗∗2, length being the µ1 complexity or McCabe complexity of the module. The f anin of a module M is the number of local flow into M plus the number of data structures read by M, The f anout of a module M is the number of local flow from M plus the number of data structures in which M writes.
> 	To avoid redundancy and to keep the complexity linear (the power of 2 only being a weight), the µ5 complexity has been redefined has the product f anin ∗ f anout. In C, the usage of pointers making the notion of variable less sensible than the notion of memory slot the f anin and f anout definitions can be understood this way : The f anin of a module M is calculated as the number of modules calling M plus the number of read effects of M. The f anout of a module M is calculated as the number of modules called by M plus the number of write effects of M. In the example on listing 4, the calculated µ5 complexity of the module foo is 3 (foo is called once and reads the variables b and matrix writes, it writes to the variable matrix, its fan-in is 3, its fan-out is 1) and the µ5 of the module main is 2. The total µ5 of the program is 5.

![image-20221119215312972](https://gitea.noel.ga/picgo/lxy-img/raw/branch/master/img/202211192153109.png)

![image-20221119215524917](https://gitea.noel.ga/picgo/lxy-img/raw/branch/master/img/202211192155005.png)

3.1.5 µ5复杂性（扇入/扇出复杂性）
	Henry和kafura定义了一个基于信息流的软件测量方法[8]：length∗(f anin ∗f anout)∗∗2。长度是模块的μ1复杂性或McCabe复杂性。一个模块M的f anin是指 一个模块M的f anin是进入M的局部流量加上M读取的数据结构的数量，一个模块M的f anout 是来自M的本地流量加上M写入的数据结构的数量。
	为了避免冗余并保持复杂性的线性（2的幂数只是一个权重），µ5 复杂性被重新定义为乘积f anin ∗ f anout。在C语言中，指针的使用使得变量的概念不如内存槽的概念合理，f anin和f anout的定义可以这样理解 可以这样理解：一个模块M的f anin被计算为调用M的模块数加上M的读效应数。一个模块M的f anin计算为调用M的模块数加上M的读效应数。在列表4的例子中，计算出的模块foo的µ5复杂度是3(3)。模块foo的计算复杂度为3（foo被调用一次，读取变量b和矩阵写，它写到 变量矩阵，其扇入为3，扇出为1），模块main的µ5为2。程序的总µ5是5。



3.1.5 µ5 复杂度（扇入/出复杂度）
	Henry 和 kafura 定义了一种基于信息流的软件度量 [8] 为 length∗(f anin ∗f anout)∗2，长度为模块的 µ1 复杂度或 McCabe 复杂度。一个模块M的fanin是进入M的本地流的数量加上M读取的数据结构的数量，一个模块M的fanout是来自M的本地流的数量加上M写入的数据结构的数量.
	为了避免冗余并保持复杂度线性（2 的次方只是一个权重），µ5 复杂度已重新定义为 f anin ∗ f anout 的乘积。在 C 语言中，指针的使用使得变量的概念不如内存槽的概念那么合理 fanin 和 fanout 定义可以这样理解：模块 M 的 fanin 计算为调用 M 的模块数加上M 的读取效果数。模块 M 的 f anout 计算为 M 调用的模块数加上 M 的写入效果数。在清单 4 的示例中，计算出的模块 foo 的 µ5 复杂度为3（foo被调用一次，读取变量b，matrix写入，写入变量matrix，扇入为3，扇出为1），模块main的µ5为2。总共µ5该程序是 5。

## 6.数据结构复杂度c6

> 3.1.6 The µ6 complexity (data structure complexity)
> 	The regular definition of the µ6 complexity of a variable is the dimension of this variable (e.g. the µ6 complexity of a vector is 1, the µ6 complexity of a matrix is 2). Since in C, the dimension of a data structure does not have the same semantic value as in other languages. The µ6 complexity of a variable has been redefined as its size (in bytes). Yet, this poses a problem with pointers. For instance : whereas a picture is often modelled as a two dimension matrix of pixels, it could be stored in a one dimension array where the pixel (i,j) will be at the j + width ∗ i position. Moreover, if an array has been declared with no dimension and its memory is dynamically allocated later in the code its dimension cannot be known statically. Dynamic allocation should be taken into account as a variable whose size is dynamically allocated is more complex that statically sized variable from an obfuscation point of view. It is handled using the µ1 complexity : the number of operands and operators inside the arguments of the called allocation function (e.g. malloc, calloc) is added to the mu6 complexity of the variable on which the allocation function is applied.
> 	In order to deal with dynamic sized arrays (e.g. int v[n];) the approximate_eval pass is called before calculating the program’s µ6 complexity to replace variable by an upper-bound of their values. If the size of a variable cannot be calculated statically and an upper-bound of its size cannot be calculated then the variable size is assumed to be 1. Finally, for the full module, its µ6 complexity sums the µ6 complexity of each involved variable. In the example on listing5, the calculated µ6 complexity of the module main is 63 (in the declaration of k, i has been approximated to 3 by the pass approximate eval).
>
> ```c
> #include <stdio.h>
> #include <stdlib.h>
> 
> typedef struct { int champ1; int champ2; long champ3; } t;
> /∗ Computed mu6 complexity of this module: 63∗/
> int main(){
> 	char ∗ s = "ma variable";
> 	char x[] = "hello world ha ha";
> 	char r[5] = "abcde";
> 	int i ;
> 	t myt = {2,3,4};
> 	if (myt.champ1 > 2){
> 		i = 3;
> 	}else{
> 		i = 1;
> 	}
> 	int k[i ];
> 	return 0;
> }
> ```

![image-20221119215742740](https://gitea.noel.ga/picgo/lxy-img/raw/branch/master/img/202211192157817.png)

3.1.6 µ6复杂性（数据结构复杂性）
	一个变量的μ6复杂性的常规定义是这个变量的维度（例如，一个向量的μ6 复杂度为1，矩阵的μ6复杂度为2）。由于在C语言中，数据结构的维度并不像其他语言那样具有相同的语义价值。一个变量的µ6复杂度 已被重新定义为其大小（以字节为单位）。然而，这给指针带来了一个问题。例如：虽然 一张图片通常被建模为一个二维的像素矩阵，它可以被存储在一个一维的 数组中，像素(i,j)将位于j + width ∗ i的位置。此外，如果一个数组被声明为没有维度，并且其内存是动态的 而它的内存在代码中被动态分配，它的尺寸就不能被静态知道。它的尺寸不能静态地知道。动态分配应该被考虑在内，因为一个变量的大小是动态分配的 从混淆的角度来看，动态分配的变量比静态分配的变量更复杂。它的处理方法是 使用µ1复杂度：被调用的分配函数的参数中的操作数和运算符数。分配函数（如malloc，calloc）的参数内的操作数和运算符的数量被添加到应用分配函数的变量的mu6复杂性中。分配函数所应用的变量的mu6复杂性。
	为了处理动态大小的数组（例如，int v[n];），在计算程序的μ值之前，会调用 approximate_eval 通道。在计算程序的μ6复杂度之前，先调用近似_eval通道，用它们的值的上限值替换变量。如果 变量的大小无法静态计算，也无法计算其大小的上限值 那么该变量的大小被假定为1。最后，对于整个模块来说，它的μ6复杂度是每个涉及的变量的μ6 复杂度的总和。在listing5的例子中，计算出的模块main的µ6复杂度是63（在声明中）。模块main的µ6复杂度为63（在k的声明中，i已经通过近似评估被近似为3了）。



3.1.6 The µ6 complexity（数据结构复杂度）
	变量的 µ6 复杂度的常规定义是该变量的维数（例如，向量的 µ6 复杂度为 1，矩阵的 µ6 复杂度为 2）。因为在 C 中，数据结构的维数与其他语言中的语义值不同。变量的 µ6 复杂度已重新定义为其大小（以字节为单位）。然而，这给指针带来了问题。例如：虽然图片通常被建模为像素的二维矩阵，但它可以存储在一维数组中，其中像素 (i,j) 将位于 j + width ∗ i 位置。此外，如果声明了一个没有维度的数组，并且稍后在代码中动态分配其内存，则无法静态知道其维度。应考虑动态分配，因为从混淆的角度来看，动态分配大小的变量比静态大小的变量更复杂。它使用 µ1 复杂度处理：被调用分配函数（例如 malloc、calloc）的参数内的操作数和运算符的数量被添加到应用分配函数的变量的 mu6 复杂度。
	为了处理动态大小的数组（例如 int v[n];），在计算程序的 µ6 复杂度之前调用 approximate_eval pass 以用变量值的上限替换变量。如果无法静态计算变量的大小并且无法计算其大小的上限，则假定变量大小为 1。最后，对于完整模块，其 µ6 复杂度是每个相关变量的 µ6 复杂度之和。在清单 5 的示例中，计算出的 main 模块的 µ6 复杂度为 63（在 k 的声明中，i 已通过 pass approximate eval 近似为 3）。

## 7.面向对象复杂度c7